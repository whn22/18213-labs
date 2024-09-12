#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#include <limits.h>
#include <errno.h>
#include "cachelab.h"

// Print the message if runs with -h
int print_Help(int h)
{
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

void print_MissArg(void)
{
    printf("Mandatory arguments missing or zero.\n");
    print_Help(1);
}

void print_unknown(int op) {
    printf("./csim: invalid option -- '%c'\n", op);
    print_Help(1);
}

void print_stats(csim_stats_t *stats) {
    printf("hits: %lu\n", stats->hits);
    printf("misses: %lu\n", stats->misses);
    printf("evictions: %lu\n", stats->evictions);
    printf("dirty_bytes: %lu\n", stats->dirty_bytes);
    printf("dirty_evictions: %lu\n", stats->dirty_evictions);
}

//set line structure
typedef struct setLine
{
    int valid;
    unsigned long tag;
    unsigned long dirty;
    int timePass;
} SetLine;

SetLine **Init_CacheSets(int s, int E)
{
    int S = 1 << s;
    SetLine **line = (SetLine **)malloc(sizeof(SetLine *) 
                        * (unsigned long)S * (unsigned long)E);
    for (int i = 0; i < S; i++)
    {
        line[i] = (SetLine *)malloc(sizeof(SetLine) * (unsigned long)E);
        for (int j = 0; j < E; j++)
        {
            line[i][j].valid = 0;
            line[i][j].tag = 0;
            line[i][j].dirty = 0;
            line[i][j].timePass = 0;
        }
    }
    return line;
}

//cache structure
typedef struct cache
{
    int s;
    int b;
    int E;
    // char* t;
    SetLine **sets; //cache sets
} Cache;

Cache *Init_Cache(int s, int b, int E)
{
    Cache *cache = (Cache *)malloc(sizeof(Cache));
    cache->s = s;
    cache->b = b;
    cache->E = E;
    cache->sets = Init_CacheSets(s, E);
    return cache;
}

void printCache(Cache *cache) {
    int S = 1 << cache->s;
    int B = 1 << cache->b;
    int E = cache->E;
    printf("S, E, B: %d, %d, %d\n", S, E, B);
	for(int i = 0; i < S; i++) {
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

void freeCache(Cache *cache)
{
    int S = 1 << cache->s;
	for(int i = 0; i < S; i++) {
        free(cache->sets[i]);
    }
    free(cache->sets);
	free(cache);    
}

void sumDirtyCache(Cache *cache, csim_stats_t *stats)
{
    int S = 1 << cache->s;
    int E = cache->E;
	for (int i = 0; i < S; i++)
		for (int j = 0; j < E; j++)
			    stats->dirty_bytes += cache->sets[i][j].dirty;
}

void updateTimePass(Cache *cache)
{
    int S = 1 << cache->s;
    int E = cache->E;
	for (int i = 0; i < S; i++)
		for (int j = 0; j < E; j++)
			if (cache->sets[i][j].valid == 1)
			    cache->sets[i][j].timePass++;
}

int findHitIndex(Cache *cache, int addrSetIndex, unsigned long addrTag) {
    // printf("position8\n");
	for(int i = 0; i < cache->E; i++) {
		if(cache->sets[addrSetIndex][i].valid == 1 &&
           cache->sets[addrSetIndex][i].tag == addrTag) {
			return i;
		}
	}
    return -1;
}

int findEmptyIndex(Cache *cache, int addrSetIndex, unsigned long addrTag) {
    for(int j = 0; j < cache->E; j++) {
        if(cache->sets[addrSetIndex][j].valid == 0) {
            return j;
        }
    }
    return -1;
}

int findMaxTPIndex(Cache *cache, int addrSetIndex, unsigned long addrTag) {
    int maxTimePass = -1;
    int maxTPIndex = -1;
    
    for(int m = 0; m < cache->E; m++) {
        if(cache->sets[addrSetIndex][m].timePass > maxTimePass)
        {
            maxTimePass = cache->sets[addrSetIndex][m].timePass;
            maxTPIndex = m;
        }
    }
    return maxTPIndex;
}

void update(unsigned long address, csim_stats_t *stats, Cache *cache,
            unsigned long size, char op, int v)
{
    int s = cache->s;
    int b = cache->b;
    unsigned long u = 0x7FFFFFFFFFFFFFFF;
    int addrSetIndex = (int)((address >> b) & (u >> (64 - s)));
    // printf("u:%lx\n", u);
    // printf("s:%d\n", s);
    // printf("u >> (64 - s):%lx\n", (u >> (64 - s)));
	unsigned long addrTag = address >> (b + s);
    int offset = (int)(address & ~(-1U << b));
    // int maxDirty = (1 << b) / size;
    if (v)
        printf("addrSetIndex: %d, addrTag: %lx, offset: %d ", 
                addrSetIndex, addrTag, offset);

    // printf("position7\n");
    // printCache(cache);
    // printf("cachetest: %lu\n", cache->sets[0][0].tag);
    // printf("cachetest: %lu\n", cache->sets[addrSetIndex][0].tag);

    int i = findHitIndex(cache, addrSetIndex, addrTag);

    if (i != -1) {
        // hit
        if (v) 
            printf("hit ");
        // printf("part1\n");
        cache->sets[addrSetIndex][i].timePass = 0;
        stats->hits++;
        if (op == 'S')
            cache->sets[addrSetIndex][i].dirty += size;
        // printCache(cache);

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
                cache->sets[addrSetIndex][emptyIndex].dirty += size;
            // printCache(cache);
        } else {
            // miss(eviction)
            if (v)
                printf("eviction ");
            stats->evictions++;
            int maxTPIndex = findMaxTPIndex(cache, addrSetIndex, addrTag);
            cache->sets[addrSetIndex][maxTPIndex].tag = addrTag;
            cache->sets[addrSetIndex][maxTPIndex].timePass = 0;
            stats->dirty_evictions += cache->
                                        sets[addrSetIndex][maxTPIndex].dirty;
            cache->sets[addrSetIndex][maxTPIndex].dirty = 0;
            // printCache(cache);
        }
    }
}

/** Process a memory-access trace file. *
* @param trace Name of the trace file to process.
* @return 0 if successful, 1 if there were errors. */

int process_trace_file(const char *trace, csim_stats_t *stats, 
                        Cache* cache, int v)
{
    printf("process_trace_file begins here\n");
    FILE *tfp = fopen(trace, "rt"); 
    
    if (!tfp) {
        fprintf(stderr, "Error opening '%s': %s\n", 
                trace, strerror(errno));
        return 1; 
    }
    // printf("position1\n");
    char linebuf[20]; // How big should LINELEN be? 
    int parse_error = 0;

    char* operation;
    unsigned long address;
    unsigned long size;

    char* other1;
    char* other2;
    // printf("position2\n");
    while (fgets(linebuf, 20, tfp)) {
        if (strlen(linebuf) == 19) {
            printf("Invaild input: This line is too long.\n");
            parse_error = 1;
        }
        // printf("position3\n");
        operation = strtok(linebuf, " ");
        int opLen = (int)strlen(operation);
        char op = operation[0];
        // printf("op: %c, opLen: %d\n", op, opLen);
        // printf("position4\n");
        address = strtoul(linebuf + opLen + 1, &other1, 16);
        size = strtoul(other1+1, &other2, 10);
        // printf("position5\n");
        // printf("operation: %s, address: %lu, size: %lu\n", 
        //        operation, address, size);
        if (v) {
            // printf("%s ", linebuf);
            printf("%s %lx,%lu ",operation, address, size);
        }
        
        if (opLen > 1 || (op != 'L' && op != 'S')) {
            printf("Invaild input: Invaild operation\n");
            parse_error = 1;
        }

        // switch(op) {
		// 	case 'L':
		// 		update(address, stats, size, s, E, b, op);
		// 		break;
		// 	case 'S':
		// 		update(address, stats, size, s, E, b, op);
        //         break;
		// }
        // printf("position6\n");
        update(address, stats, cache, size, op, v);
		updateTimePass(cache);
        // print_stats(stats);
        if (v) {
            printf("\n");
        }
    }

    fclose(tfp);
    // printf("process_trace_file end here\n");
    return parse_error;
}

int main(int argc, char **argv) 
{
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
                // printf("Number of set index bits is %d.\n", s);
				break;
			case 'E':
                args++;
                E = atoi(optarg);
                // printf("Number of line bits is %d.\n", E);
				break;
			case 'b':
                args++;
                b = atoi(optarg);
                // printf("Number of block bits is %d.\n", b);
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
                print_unknown(optopt);
				break;
            default:
                break;
        }
    }

    // printf("number of vaild arguments:%d\n", args);
    // printf("s, E, b, t: %d, %d, %d, %s\n", s, E, b, t);

    if (args < 4) {
        print_MissArg();
        return -1;
    }

    if (v) {
        printf("verbose mode on.\n");
    }

    Cache *cache = Init_Cache(s, b, E);
    
    printCache(cache);
    
    process_trace_file(t, stats, cache, v);
    sumDirtyCache(cache, stats);
    printSummary(stats);
    freeCache(cache);
    free(stats);
    free(t);

    return 0; 
}
