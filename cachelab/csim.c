#include "cachelab.h"
#include <errno.h>
#include <getopt.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

/**
 * @file csim.c
 * @brief a cache simulator that simulates the behavior of a cache
 *
 * This program reads a trace file and several arguments (h v s E b).
 * It outputs the total number of hits, misses, and evictions, the number of
 * dirty bytes that have been evicted and the number of dirty bytes in the cache
 * at the end.
 *
 * It uses the LRU (least-recently used) replacement policy when choosing which
 * cache line to evict, and follow a write-back, write-allocate policy.
 */

// Print the message if runs with -h
int print_Help(int h) {
    printf("Usage: ./csim [-v] -s <s> -E <E> -b <b> -t <trace>\n"
           "./csim -h\n"
           "\n"
           "-h          Print this help message and exit\n"
           "-v          Verbose mode: report effects of each "
           "memory operation\n"
           "-s <s>      Number of set index bits (there are 2**s sets)\n"
           "-b <b>      Number of block bits (there are 2**b blocks)\n"
           "-E <E>      Number of lines per set (associativity)\n"
           "-t <trace>  File name of the memory trace to process\n"
           "\n"
           "The -s, -b, -E, and -t options must be supplied for all "
           "simulations.\n");
    return h;
}

// Print the message if missing arguments
void print_MissArg(void) {
    printf("Mandatory arguments missing or zero.\n");
    print_Help(1);
}

// Print the message if there are unknown arguments (other than h v s E b)
void print_unknown(void) {
    print_Help(1);
}

// Helper function for debugging
void print_stats(csim_stats_t *stats) {
    printf("hits: %lu\n", stats->hits);
    printf("misses: %lu\n", stats->misses);
    printf("evictions: %lu\n", stats->evictions);
    printf("dirty_bytes: %lu\n", stats->dirty_bytes);
    printf("dirty_evictions: %lu\n", stats->dirty_evictions);
}

// set line structure
typedef struct setLine {
    int valid;
    unsigned long tag;
    unsigned long dirty;
    int timePass;
} SetLine;

// create and initiate empty cachesets
SetLine **Init_CacheSets(int s, int E) {
    int S = 1 << s;
    SetLine **line = (SetLine **)malloc(sizeof(SetLine *) * (unsigned long)S *
                                        (unsigned long)E);
    for (int i = 0; i < S; i++) {
        line[i] = (SetLine *)malloc(sizeof(SetLine) * (unsigned long)E);
        for (int j = 0; j < E; j++) {
            line[i][j].valid = 0;
            line[i][j].tag = 0;
            line[i][j].dirty = 0;
            line[i][j].timePass = 0;
        }
    }
    return line;
}

// cache structure
typedef struct cache {
    int s;
    int b;
    int E;
    SetLine **sets; // cache sets
} Cache;

// create and initiate an empty cache
Cache *Init_Cache(int s, int b, int E) {
    Cache *cache = (Cache *)malloc(sizeof(Cache));
    cache->s = s;
    cache->b = b;
    cache->E = E;
    cache->sets = Init_CacheSets(s, E);
    return cache;
}

// Helper function for debugging
void printCache(Cache *cache) {
    int S = 1 << cache->s;
    int B = 1 << cache->b;
    int E = cache->E;
    printf("S, E, B: %d, %d, %d\n", S, E, B);
    for (int i = 0; i < S; i++) {
        for (int j = 0; j < E; j++) {
            printf("%d ", cache->sets[i][j].valid);
            printf("%lu ", cache->sets[i][j].tag);
            printf("%lu ", cache->sets[i][j].dirty);
            printf("%d ", cache->sets[i][j].timePass);
            printf(" | ");
        }
        printf("\n");
    }
}

// freeing a cache
void freeCache(Cache *cache) {
    int S = 1 << cache->s;
    for (int i = 0; i < S; i++) {
        free(cache->sets[i]);
    }
    free(cache->sets);
    free(cache);
}

// sum all dirty bytes in cache
void sumDirtyCache(Cache *cache, csim_stats_t *stats) {
    int S = 1 << cache->s;
    int E = cache->E;
    for (int i = 0; i < S; i++)
        for (int j = 0; j < E; j++)
            stats->dirty_bytes += cache->sets[i][j].dirty;
}

// increment timePass in every cache line by 1
void updateTimePass(Cache *cache) {
    int S = 1 << cache->s;
    int E = cache->E;
    for (int i = 0; i < S; i++)
        for (int j = 0; j < E; j++)
            if (cache->sets[i][j].valid == 1)
                cache->sets[i][j].timePass++;
}

// if hit, return the hit index, if miss, return -1
int findHitIndex(Cache *cache, int addrSetIndex, unsigned long addrTag) {
    for (int i = 0; i < cache->E; i++) {
        if (cache->sets[addrSetIndex][i].valid == 1 &&
            cache->sets[addrSetIndex][i].tag == addrTag) {
            return i;
        }
    }
    return -1;
}

// if there is an empty line, return the index, if no, return -1
int findEmptyIndex(Cache *cache, int addrSetIndex, unsigned long addrTag) {
    for (int j = 0; j < cache->E; j++) {
        if (cache->sets[addrSetIndex][j].valid == 0) {
            return j;
        }
    }
    return -1;
}

// find the line with the maximum timePass
int findMaxTPIndex(Cache *cache, int addrSetIndex, unsigned long addrTag) {
    int maxTimePass = -1;
    int maxTPIndex = -1;

    for (int m = 0; m < cache->E; m++) {
        if (cache->sets[addrSetIndex][m].timePass > maxTimePass) {
            maxTimePass = cache->sets[addrSetIndex][m].timePass;
            maxTPIndex = m;
        }
    }
    return maxTPIndex;
}

// update a cache line according to the given address in linebuf
void update(unsigned long address, csim_stats_t *stats, Cache *cache, char op,
            int v) {
    int s = cache->s;
    int b = cache->b;
    unsigned B = 1 << b;
    int addrSetIndex = (int)((address >> b) & (-1U >> (64 - s)));
    if (s == 0)
        addrSetIndex = 0;
    unsigned long addrTag = address >> (b + s);

    int i = findHitIndex(cache, addrSetIndex, addrTag);

    if (i != -1) {
        // hit
        if (v)
            printf("hit ");
        cache->sets[addrSetIndex][i].timePass = 0;
        stats->hits++;
        if (op == 'S')
            cache->sets[addrSetIndex][i].dirty = B;

    } else {
        // miss
        if (v)
            printf("miss ");
        stats->misses++;
        int emptyIndex = findEmptyIndex(cache, addrSetIndex, addrTag);
        if (emptyIndex != -1) {
            // miss(empty)
            cache->sets[addrSetIndex][emptyIndex].valid = 1;
            cache->sets[addrSetIndex][emptyIndex].tag = addrTag;
            cache->sets[addrSetIndex][emptyIndex].timePass = 0;
            if (op == 'S')
                cache->sets[addrSetIndex][emptyIndex].dirty = B;
        } else {
            // miss(eviction)
            if (v)
                printf("eviction ");
            stats->evictions++;
            int maxTPIndex = findMaxTPIndex(cache, addrSetIndex, addrTag);
            cache->sets[addrSetIndex][maxTPIndex].tag = addrTag;
            cache->sets[addrSetIndex][maxTPIndex].timePass = 0;
            stats->dirty_evictions +=
                cache->sets[addrSetIndex][maxTPIndex].dirty;
            cache->sets[addrSetIndex][maxTPIndex].dirty = 0;
            if (op == 'S')
                cache->sets[addrSetIndex][maxTPIndex].dirty = B;
        }
    }
}

/** Process a memory-access trace file. *
 * @param trace Name of the trace file to process.
 * @return 0 if successful, 1 if there were errors. */

int process_trace_file(const char *trace, csim_stats_t *stats, Cache *cache,
                       int v) {
    FILE *tfp = fopen(trace, "rt");

    if (!tfp) {
        fprintf(stderr, "Error opening '%s': %s\n", trace, strerror(errno));
        return 1;
    }

    char linebuf[20];
    int parse_error = 0;

    char *operation;
    unsigned long address;
    // unsigned long size; // This value is reserved for calculationg dirty byte

    char *other1;
    // char *other2; // reserved for calculate size
    while (fgets(linebuf, 20, tfp)) {
        if (strlen(linebuf) == 19) {
            printf("Invaild input: This line is too long.\n");
            parse_error = 1;
        }

        operation = strtok(linebuf, " ");
        int opLen = (int)strlen(operation);
        char op = operation[0];

        address = strtoul(linebuf + opLen + 1, &other1, 16);
        // size = strtoul(other1 + 1, &other2, 10);

        if (opLen > 1 || (op != 'L' && op != 'S')) {
            printf("Invaild input: Invaild operation\n");
            parse_error = 1;
        }

        update(address, stats, cache, op, v);
        updateTimePass(cache);

        if (v) {
            printf("\n");
        }
    }

    fclose(tfp);
    return parse_error;
}

// reads several arguments and print a summary of stats
int main(int argc, char **argv) {
    csim_stats_t *stats = malloc(sizeof(csim_stats_t));
    stats->hits = 0;
    stats->misses = 0;
    stats->evictions = 0;
    stats->dirty_bytes = 0;
    stats->dirty_evictions = 0;

    int h = 0;
    int v = 0;
    int s = 0;
    int b = 0;
    int E = 0;
    int args = 0;
    int opt;
    char *t = malloc(sizeof(char) * 100);

    while ((opt = getopt(argc, argv, "hvs:E:b:t:")) != -1) {
        switch (opt) {
        case 'h':
            h = 1;
            print_Help(h);
            return 1;
        case 'v':
            v = 1;
            break;
        case 's':
            args++;
            s = atoi(optarg);
            break;
        case 'E':
            args++;
            E = atoi(optarg);
            break;
        case 'b':
            args++;
            b = atoi(optarg);
            break;
        case 't':
            args++;
            if (t == NULL) {
                printf("Memory allocation error\n");
                return -1;
            }
            strcpy(t, optarg);
            break;
        case '?':
            print_unknown();
            return -1;
        default:
            break;
        }
    }

    if (args < 4) {
        print_MissArg();
        return -1;
    }

    if (v) {
        printf("verbose mode on.\n");
    }

    Cache *cache = Init_Cache(s, b, E);

    process_trace_file(t, stats, cache, v);
    sumDirtyCache(cache, stats);
    printSummary(stats);
    freeCache(cache);
    free(stats);
    free(t);

    return 0;
}
