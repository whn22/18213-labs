/**
 * @file tsh.c
 * @brief A tiny shell program with job control
 *
 * @author Sunny Wu <hanningw@andrew.cmu.edu>
 */

#include "csapp.h"
#include "tsh_helper.h"

#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

#include <signal.h>

/*
 * If DEBUG is defined, enable contracts and printing on dbg_printf.
 */
#ifdef DEBUG
/* When debugging is enabled, these form aliases to useful functions */
#define dbg_printf(...) printf(__VA_ARGS__)
#define dbg_requires(...) assert(__VA_ARGS__)
#define dbg_assert(...) assert(__VA_ARGS__)
#define dbg_ensures(...) assert(__VA_ARGS__)
#else
/* When debugging is disabled, no code gets generated for these */
#define dbg_printf(...)
#define dbg_requires(...)
#define dbg_assert(...)
#define dbg_ensures(...)
#endif

/* Function prototypes */
void eval(const char *cmdline);

void sigchld_handler(int sig);
void sigtstp_handler(int sig);
void sigint_handler(int sig);
void sigquit_handler(int sig);
void cleanup(void);

// extern char **environ;

/**
 * @brief implement tsh
 */
int main(int argc, char **argv) {
    int c;
    char cmdline[MAXLINE_TSH]; // Cmdline for fgets
    bool emit_prompt = true;   // Emit prompt (default)

    // Redirect stderr to stdout (so that driver will get all output
    // on the pipe connected to stdout)
    if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
        perror("dup2 error");
        exit(1);
    }

    // Parse the command line
    while ((c = getopt(argc, argv, "hvp")) != EOF) {
        switch (c) {
        case 'h': // Prints help message
            usage();
            break;
        case 'v': // Emits additional diagnostic info
            verbose = true;
            break;
        case 'p': // Disables prompt printing
            emit_prompt = false;
            break;
        default:
            usage();
        }
    }

    // Create environment variable
    if (putenv(strdup("MY_ENV=42")) < 0) {
        perror("putenv error");
        exit(1);
    }

    // Set buffering mode of stdout to line buffering.
    // This prevents lines from being printed in the wrong order.
    if (setvbuf(stdout, NULL, _IOLBF, 0) < 0) {
        perror("setvbuf error");
        exit(1);
    }

    // Initialize the job list
    init_job_list();

    // Register a function to clean up the job list on program termination.
    // The function may not run in the case of abnormal termination (e.g. when
    // using exit or terminating due to a signal handler), so in those cases,
    // we trust that the OS will clean up any remaining resources.
    if (atexit(cleanup) < 0) {
        perror("atexit error");
        exit(1);
    }

    // Install the signal handlers
    Signal(SIGINT, sigint_handler);   // Handles Ctrl-C
    Signal(SIGTSTP, sigtstp_handler); // Handles Ctrl-Z
    Signal(SIGCHLD, sigchld_handler); // Handles terminated or stopped child

    Signal(SIGTTIN, SIG_IGN);
    Signal(SIGTTOU, SIG_IGN);

    Signal(SIGQUIT, sigquit_handler);

    // Execute the shell's read/eval loop
    while (true) {
        if (emit_prompt) {
            printf("%s", prompt);

            // We must flush stdout since we are not printing a full line.
            fflush(stdout);
        }

        if ((fgets(cmdline, MAXLINE_TSH, stdin) == NULL) && ferror(stdin)) {
            perror("fgets error");
            exit(1);
        }

        if (feof(stdin)) {
            // End of file (Ctrl-D)
            printf("\n");
            return 0;
        }

        // Remove any trailing newline
        char *newline = strchr(cmdline, '\n');
        if (newline != NULL) {
            *newline = '\0';
        }

        // Evaluate the command line
        eval(cmdline);
    }

    return -1; // control never reaches here
}

/**
 * @brief Wait until process pid is no longer the foreground process
 */
void waitfg(pid_t pid) {
    sigset_t mask;
    sigemptyset(&mask);
    jid_t jid = job_from_pid(pid);
    while (fg_job() == jid) {
        sigsuspend(&mask);
    }
    return;
}

/**
 * @brief Execute the builtin bg and fg commands
 */
void do_bgfg(struct cmdline_tokens token, sigset_t mask_all,
             sigset_t prev_one) {
    int state;
    int jid = 0;
    int pid = 0;

    if (token.builtin == BUILTIN_FG)
        state = FG;
    else
        state = BG;

    if (token.argv[1] == NULL) {
        printf("%s command requires PID or %%jobid argument\n", token.argv[0]);
        return;
    }
    if (token.argv[1][0] == '%') {
        if (sscanf(&token.argv[1][1], "%d", &jid) > 0) {
            sigprocmask(SIG_BLOCK, &mask_all, NULL);
            if (!job_exists(jid)) {
                printf("%%%d: No such job\n", jid);
                sigprocmask(SIG_SETMASK, &prev_one, NULL);
                return;
            }
            pid = job_get_pid(jid);
            sigprocmask(SIG_SETMASK, &prev_one, NULL);
        }
    } else if (isdigit(token.argv[1][0])) {
        pid = atoi(token.argv[1]);
        sigprocmask(SIG_BLOCK, &mask_all, NULL);
        jid = job_from_pid(pid);
        if (!job_exists(jid)) {
            printf("(%d): No such process\n", pid);
            sigprocmask(SIG_SETMASK, &prev_one, NULL);
            return;
        }
        sigprocmask(SIG_SETMASK, &prev_one, NULL);
    } else {
        printf("%s: argument must be a PID or %%jobid\n", token.argv[0]);
        return;
    }

    kill(-pid, SIGCONT);
    sigprocmask(SIG_BLOCK, &mask_all, NULL);
    job_set_state(jid, state);
    if (state == BG)
        printf("[%d] (%d) %s\n", jid, pid, job_get_cmdline(jid));
    else
        waitfg(pid);
    sigprocmask(SIG_SETMASK, &prev_one, NULL);
    return;
}

/**
 * @brief If the user has typed a built-in command then execute it immediately.
 */
int builtin_cmd(struct cmdline_tokens token, sigset_t mask_all,
                sigset_t prev_one) {
    int olderror = errno;
    builtin_state builtin = token.builtin;

    if (builtin == BUILTIN_QUIT) {
        exit(0);
    } else if (builtin == BUILTIN_JOBS) {
        if (token.outfile != NULL) {
            int fd =
                open(token.outfile, O_CREAT | O_TRUNC | O_WRONLY, DEF_MODE);
            if (fd != -1) {
                sigprocmask(SIG_BLOCK, &mask_all, NULL);
                list_jobs(fd);
                sigprocmask(SIG_SETMASK, &prev_one, NULL);
                errno = olderror;
                return 1;
            } else {
                if (errno == EACCES) {
                    sio_printf("%s: Permission denied\n", token.outfile);
                } else {
                    sio_printf("%s: No such file or directory\n",
                               token.outfile);
                }
                errno = olderror;
                return 1;
            }
        } else {
            sigprocmask(SIG_BLOCK, &mask_all, NULL);
            list_jobs(STDERR_FILENO);
            sigprocmask(SIG_SETMASK, &prev_one, NULL);
            errno = olderror;
            return 1;
        }
    } else if (builtin == BUILTIN_FG || builtin == BUILTIN_BG) {
        do_bgfg(token, mask_all, prev_one);
        errno = olderror;
        return 1;
    }
    return 0;
}

/**
 * @brief I/O redirection
 */
bool IO_redirection(struct cmdline_tokens token) {
    int olderror = errno;

    if (token.infile != NULL) {
        int fd_in = open(token.infile, O_RDONLY, DEF_MODE);
        if (fd_in != -1) {
            if (dup2(fd_in, STDIN_FILENO) == -1) {
                sio_printf("dup process errors:%s\n", token.infile);
                errno = olderror;
                return false;
            }
        } else {
            if (errno == EACCES) {
                sio_eprintf("%s: Permission denied\n", token.infile);
            } else {
                sio_eprintf("%s: No such file or directory\n", token.infile);
            }

            errno = olderror;
            return false;
        }
    }

    if (token.outfile != NULL) {
        int fd_out =
            open(token.outfile, O_WRONLY | O_CREAT | O_TRUNC, DEF_MODE);
        if (fd_out != -1) {
            if (dup2(fd_out, STDOUT_FILENO) == -1) {
                sio_printf("dup process errors:%s\n", token.outfile);
                errno = olderror;
                return false;
            }

        } else {
            if (errno == EACCES) {
                sio_eprintf("%s: Permission denied\n", token.outfile);
            } else {
                sio_eprintf("%s: No such file or directory\n", token.outfile);
            }
            errno = olderror;
            return false;
        }
    }

    errno = olderror;
    return true;
}

/**
 * @brief Main routine that parses, interprets, and executes the command line.
 *
 * NOTE: The shell is supposed to be a long-running process, so this function
 *       (and its helpers) should avoid exiting on error.  This is not to say
 *       they shouldn't detect and print (or otherwise handle) errors!
 */
void eval(const char *cmdline) {

    parseline_return parse_result;
    struct cmdline_tokens token;

    // Parse command line
    parse_result = parseline(cmdline, &token);

    if (parse_result == PARSELINE_ERROR || parse_result == PARSELINE_EMPTY) {
        return;
    }

    sigset_t mask_all, mask_one, prev_one;
    sigfillset(&mask_all);
    sigemptyset(&mask_one);
    sigaddset(&mask_one, SIGCHLD);

    pid_t pid = 0;
    if (builtin_cmd(token, mask_all, prev_one) == 0) {
        sigprocmask(SIG_BLOCK, &mask_all, &prev_one);

        if ((pid = fork()) == 0) {
            sigprocmask(SIG_SETMASK, &prev_one, NULL);
            setpgid(0, 0);
            if (!IO_redirection(token)) {
                exit(0);
            }
            if (execve(token.argv[0], token.argv, environ) < 0) {
                if (errno == EACCES)
                    sio_printf("%s: Permission denied\n", cmdline);
                else
                    printf("%s: No such file or directory\n", cmdline);
                exit(0);
            }
        }

        if (parse_result == PARSELINE_FG) {
            sigprocmask(SIG_BLOCK, &mask_all, NULL);
            add_job(pid, FG, cmdline);
            waitfg(pid);
            sigprocmask(SIG_SETMASK, &mask_one, NULL);
        } else {
            sigprocmask(SIG_BLOCK, &mask_all, NULL);
            add_job(pid, BG, cmdline);
            printf("[%d] (%d) %s\n", job_from_pid(pid), pid, cmdline);
            sigprocmask(SIG_SETMASK, &mask_one, NULL);
        }

        sigprocmask(SIG_SETMASK, &prev_one, NULL);
    }
    return;
}

/*****************
 * Signal handlers
 *****************/

/**
 * @brief Handles SIGCHLD signals.
 */
void sigchld_handler(int sig) {
    int olderrno = errno;
    int status;
    pid_t pid;
    sigset_t mask, prev;
    sigfillset(&mask);

    while ((pid = waitpid(-1, &status, WNOHANG | WUNTRACED)) > 0) {
        sigprocmask(SIG_BLOCK, &mask, &prev);
        jid_t jid = job_from_pid(pid);
        if (WIFEXITED(status)) {
            delete_job(jid);
        } else if (WIFSIGNALED(status)) {
            printf("Job [%d] (%d) terminated by signal %d\n", jid, pid,
                   WTERMSIG(status));
            delete_job(jid);
        } else if (WIFSTOPPED(status)) {
            printf("Job [%d] (%d) stopped by signal %d\n", jid, pid,
                   WSTOPSIG(status));
            job_set_state(jid, ST);
        }
        sigprocmask(SIG_SETMASK, &prev, NULL);
    }
    errno = olderrno;
    return;
}

/**
 * @brief Handles SIGINT signals (sent by Ctrl-C).
 */
void sigint_handler(int sig) {
    int jid, pid;
    int save_errno = errno;
    sigset_t mask_all, prev;
    sigfillset(&mask_all);
    sigprocmask(SIG_BLOCK, &mask_all, &prev);

    if ((jid = fg_job()) != 0) {
        pid = job_get_pid(jid);
        sigprocmask(SIG_SETMASK, &prev, NULL);
        kill(-pid, SIGINT);
    }
    errno = save_errno;
    return;
}

/**
 * @brief Handles SIGTSTP signals (sent by Ctrl-Z).
 */
void sigtstp_handler(int sig) {
    int jid, pid;
    int save_errno = errno;
    sigset_t mask_all, prev;
    sigfillset(&mask_all);
    sigprocmask(SIG_BLOCK, &mask_all, &prev);

    if ((jid = fg_job()) > 0) {
        pid = job_get_pid(jid);
        sigprocmask(SIG_SETMASK, &prev, NULL);
        kill(-pid, SIGTSTP);
    }
    errno = save_errno;
    return;
}

/**
 * @brief Attempt to clean up global resources when the program exits.
 *
 * In particular, the job list must be freed at this time, since it may
 * contain leftover buffers from existing or even deleted jobs.
 */
void cleanup(void) {
    // Signals handlers need to be removed before destroying the joblist
    Signal(SIGINT, SIG_DFL);  // Handles Ctrl-C
    Signal(SIGTSTP, SIG_DFL); // Handles Ctrl-Z
    Signal(SIGCHLD, SIG_DFL); // Handles terminated or stopped child

    destroy_job_list();
}
