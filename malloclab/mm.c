/**
 * @file mm.c
 * @brief A 64-bit struct-based implicit free list memory allocator
 *
 * 15-213: Introduction to Computer Systems
 *
 * TODO: insert your documentation here. :)
 *
 *************************************************************************
 *
 * ADVICE FOR STUDENTS.
 * - Step 0: Please read the writeup!
 * - Step 1: Write your heap checker.
 * - Step 2: Write contracts / debugging assert statements.
 * - Good luck, and have fun!
 *
 *************************************************************************
 *
 * @author Your Name <andrewid@andrew.cmu.edu>
 */

#include <assert.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "memlib.h"
#include "mm.h"

/* Do not change the following! */

#ifdef DRIVER
/* create aliases for driver tests */
#define malloc mm_malloc
#define free mm_free
#define realloc mm_realloc
#define calloc mm_calloc
#define memset mem_memset
#define memcpy mem_memcpy
#endif /* def DRIVER */

/* You can change anything from here onward */

/*
 *****************************************************************************
 * If DEBUG is defined (such as when running mdriver-dbg), these macros      *
 * are enabled. You can use them to print debugging output and to check      *
 * contracts only in debug mode.                                             *
 *                                                                           *
 * Only debugging macros with names beginning "dbg_" are allowed.            *
 * You may not define any other macros having arguments.                     *
 *****************************************************************************
 */
#ifdef DEBUG
/* When DEBUG is defined, these form aliases to useful functions */
#define dbg_requires(expr) assert(expr)
#define dbg_assert(expr) assert(expr)
#define dbg_ensures(expr) assert(expr)
#define dbg_printf(...) ((void)printf(__VA_ARGS__))
#define dbg_printheap(...) print_heap(__VA_ARGS__)
#else
/* When DEBUG is not defined, these should emit no code whatsoever,
 * not even from evaluation of argument expressions.  However,
 * argument expressions should still be syntax-checked and should
 * count as uses of any variables involved.  This used to use a
 * straightforward hack involving sizeof(), but that can sometimes
 * provoke warnings about misuse of sizeof().  I _hope_ that this
 * newer, less straightforward hack will be more robust.
 * Hat tip to Stack Overflow poster chqrlie (see
 * https://stackoverflow.com/questions/72647780).
 */
#define dbg_discard_expr_(...) ((void)((0) && printf(__VA_ARGS__)))
#define dbg_requires(expr) dbg_discard_expr_("%d", !(expr))
#define dbg_assert(expr) dbg_discard_expr_("%d", !(expr))
#define dbg_ensures(expr) dbg_discard_expr_("%d", !(expr))
#define dbg_printf(...) dbg_discard_expr_(__VA_ARGS__)
#define dbg_printheap(...) ((void)((0) && print_heap(__VA_ARGS__)))
#endif

/* Basic constants */

typedef uint64_t word_t;

/** @brief Word and header size (bytes) */
static const size_t wsize = sizeof(word_t);

/** @brief Double word size (bytes) */
static const size_t dsize = 2 * wsize;

/** @brief Minimum block size (bytes) */
static const size_t min_block_size = 2 * dsize;

/** @brief size of segregated list*/
static const size_t seg_size = 20;

/** @brief 16 byte alignment*/
static const size_t align = 16;

/**
 * TODO: explain what chunksize is
 * (Must be divisible by dsize)
 */
static const size_t chunksize = (1 << 12);

/**
 * TODO: explain what alloc_mask is
 */
static const word_t alloc_mask = 0x1;

/**
 * TODO: explain what size_mask is
 */
static const word_t size_mask = ~(word_t)0xF;

/** @brief Represents the header and payload of one block in the heap */
typedef struct block {
    /** @brief Header contains size + allocation flag */
    word_t header;

    /**
     * @brief A pointer to the block payload.
     */
    union {
        struct {
            struct block *pred;
            struct block *succ;
        };
        char payload[0];
    };
} block_t;

typedef union root {
    word_t header;
    struct block *first;
} root_t;

/* Global variables */

/** @brief Pointer to first block in the heap */
static block_t *heap_start = NULL;

/** @brief Create the initial empty heap */
root_t *heap_list = NULL;

/*
 *****************************************************************************
 * The functions below are short wrapper functions to perform                *
 * bit manipulation, pointer arithmetic, and other helper operations.        *
 *                                                                           *
 * We've given you the function header comments for the functions below      *
 * to help you understand how this baseline code works.                      *
 *                                                                           *
 * Note that these function header comments are short since the functions    *
 * they are describing are short as well; you will need to provide           *
 * adequate details for the functions that you write yourself!               *
 *****************************************************************************
 */

/*
 * ---------------------------------------------------------------------------
 *                        BEGIN SHORT HELPER FUNCTIONS
 * ---------------------------------------------------------------------------
 */

/**
 * @brief Returns the maximum of two integers.
 * @param[in] x
 * @param[in] y
 * @return `x` if `x > y`, and `y` otherwise.
 */
static size_t max(size_t x, size_t y) {
    return (x > y) ? x : y;
}

/**
 * @brief Rounds `size` up to next multiple of n
 * @param[in] size
 * @param[in] n
 * @return The size after rounding up
 */
static size_t round_up(size_t size, size_t n) {
    return n * ((size + (n - 1)) / n);
}

/**
 * @brief Packs the `size` and `alloc` of a block into a word suitable for
 *        use as a packed value.
 *
 * Packed values are used for both headers and footers.
 *
 * The allocation status is packed into the lowest bit of the word.
 *
 * @param[in] size The size of the block being represented
 * @param[in] alloc True if the block is allocated
 * @return The packed value
 */
static word_t pack(size_t size, bool alloc) {
    word_t word = size;
    if (alloc) {
        word |= alloc_mask;
    }
    return word;
}

/**
 * @brief Extracts the size represented in a packed word.
 *
 * This function simply clears the lowest 4 bits of the word, as the heap
 * is 16-byte aligned.
 *
 * @param[in] word
 * @return The size of the block represented by the word
 */
static size_t extract_size(word_t word) {
    return (word & size_mask);
}

/**
 * @brief Extracts the size of a block from its header.
 * @param[in] block
 * @return The size of the block
 */
static size_t get_size(block_t *block) {
    return extract_size(block->header);
}

/**
 * @brief Given a payload pointer, returns a pointer to the corresponding
 *        block.
 * @param[in] bp A pointer to a block's payload
 * @return The corresponding block
 */
static block_t *payload_to_header(void *bp) {
    return (block_t *)((char *)bp - offsetof(block_t, payload));
}

/**
 * @brief Given a block pointer, returns a pointer to the corresponding
 *        payload.
 * @param[in] block
 * @return A pointer to the block's payload
 * @pre The block must be a valid block, not a boundary tag.
 */
static void *header_to_payload(block_t *block) {
    dbg_requires(get_size(block) != 0);
    return (void *)(block->payload);
}

/**
 * @brief Given a block pointer, returns a pointer to the corresponding
 *        footer.
 * @param[in] block
 * @return A pointer to the block's footer
 * @pre The block must be a valid block, not a boundary tag.
 */
static word_t *header_to_footer(block_t *block) {
    dbg_requires(get_size(block) != 0 &&
                 "Called header_to_footer on the epilogue block");
    return (word_t *)(block->payload + get_size(block) - dsize);
}

/**
 * @brief Given a block footer, returns a pointer to the corresponding
 *        header.
 * @param[in] footer A pointer to the block's footer
 * @return A pointer to the start of the block
 * @pre The footer must be the footer of a valid block, not a boundary tag.
 */
static block_t *footer_to_header(word_t *footer) {
    size_t size = extract_size(*footer);
    dbg_assert(size != 0 && "Called footer_to_header on the prologue block");
    return (block_t *)((char *)footer + wsize - size);
}

/**
 * @brief Returns the payload size of a given block.
 *
 * The payload size is equal to the entire block size minus the sizes of the
 * block's header and footer.
 *
 * @param[in] block
 * @return The size of the block's payload
 */
static size_t get_payload_size(block_t *block) {
    size_t asize = get_size(block);
    return asize - dsize;
}

/**
 * @brief Returns the allocation status of a given header value.
 *
 * This is based on the lowest bit of the header value.
 *
 * @param[in] word
 * @return The allocation status correpsonding to the word
 */
static bool extract_alloc(word_t word) {
    return (bool)(word & alloc_mask);
}

/**
 * @brief Returns the allocation status of a block, based on its header.
 * @param[in] block
 * @return The allocation status of the block
 */
static bool get_alloc(block_t *block) {
    return extract_alloc(block->header);
}

/**
 * @brief Writes an epilogue header at the given address.
 *
 * The epilogue header has size 0, and is marked as allocated.
 *
 * @param[out] block The location to write the epilogue header
 */
static void write_epilogue(block_t *block) {
    dbg_requires(block != NULL);
    dbg_requires((char *)block == (char *)mem_heap_hi() - 7);
    block->header = pack(0, true);
}

/**
 * @brief Writes a block starting at the given address.
 *
 * This function writes both a header and footer, where the location of the
 * footer is computed in relation to the header.
 *
 * TODO: Are there any preconditions or postconditions?
 *
 * @param[out] block The location to begin writing the block header
 * @param[in] size The size of the new block
 * @param[in] alloc The allocation status of the new block
 */
static void write_block(block_t *block, size_t size, bool alloc) {
    dbg_requires(block != NULL);
    dbg_requires(size > 0);
    block->header = pack(size, alloc);
    word_t *footerp = header_to_footer(block);
    *footerp = pack(size, alloc);
}

/**
 * @brief Writes a block starting at the given address.
 *
 * This function writes both a header and footer, where the location of the
 * footer is computed in relation to the header.
 *
 * TODO: Are there any preconditions or postconditions?
 *
 * @param[out] block The location to begin writing the block header
 * @param[in] size The size of the new block
 * @param[in] alloc The allocation status of the new block
 */
static void write_header(block_t *block, size_t size, bool alloc) {
    dbg_requires(block != NULL);
    dbg_requires(size > 0);
    block->header = pack(size, alloc);
}

/**
 * @brief Finds the next consecutive block on the heap.
 *
 * This function accesses the next block in the "implicit list" of the heap
 * by adding the size of the block.
 *
 * @param[in] block A block in the heap
 * @return The next consecutive block on the heap
 * @pre The block is not the epilogue
 */
static block_t *find_next(block_t *block) {
    dbg_requires(block != NULL);
    dbg_requires(get_size(block) != 0 &&
                 "Called find_next on the last block in the heap");
    return (block_t *)((char *)block + get_size(block));
}

/**
 * @brief Finds the footer of the previous block on the heap.
 * @param[in] block A block in the heap
 * @return The location of the previous block's footer
 */
static word_t *find_prev_footer(block_t *block) {
    // Compute previous footer position as one word before the header
    // dbg_printf("find prev footer (block: %p)\n", (void*)block);
    return &(block->header) - 1;
}

/**
 * @brief Finds the previous consecutive block on the heap.
 *
 * This is the previous block in the "implicit list" of the heap.
 *
 * If the function is called on the first block in the heap, NULL will be
 * returned, since the first block in the heap has no previous block!
 *
 * The position of the previous block is found by reading the previous
 * block's footer to determine its size, then calculating the start of the
 * previous block based on its size.
 *
 * @param[in] block A block in the heap
 * @return The previous consecutive block in the heap.
 */
static block_t *find_Fprev(block_t *block) {
    dbg_requires(block != NULL);
    word_t *footerp = find_prev_footer(block);
    // dbg_printf("footerp address: %p\n", (void*)footerp);
    // dbg_printf("footerp: %lx\n", *footerp);

    // Return NULL if called on first block in the heap
    if (extract_size(*footerp) == 0) {
        return NULL;
    }

    return footer_to_header(footerp);
}

static void print_block(block_t *block) {
    if (block == NULL) {
        dbg_printf("block is NULL\n");
        return;
    }
    size_t size = get_size(block);
    size_t alloc = 0;
    if (get_alloc(block))
        alloc = 1;
    dbg_printf("%p | size:%zu, alloc:%zu\n", (void *)block, size, alloc);
}

static void print_heap() {
    dbg_printf("Start:\n");
    block_t *block;
    for (block = heap_start; get_size(block) > 0; block = find_next(block)) {
        print_block(block);
    }
    dbg_printf("End\n");
}

static void print_freeList() {
    for (size_t i = 0; i < seg_size; i++) {
        block_t *block = heap_list[i].first;
        dbg_printf("%p (root %zu): \n", (void *)&heap_list[i], i);
        while (block != NULL) {
            // dbg_printf("    pred: ");
            // print_block(block->pred);
            dbg_printf("    ");
            print_block(block);
            // dbg_printf("    succ: ");
            // print_block(block->succ);
            // dbg_printf("\n");
            block = block->succ;
        }
    }
}
/*
 * ---------------------------------------------------------------------------
 *                        END SHORT HELPER FUNCTIONS
 * ---------------------------------------------------------------------------
 */

/******** The remaining content below are helper and debug routines ********/

/*
 * search root
 */
static size_t search(size_t size) {
    size_t i;
    for (i = 0; i < (seg_size - 1); i++) {
        if (size <= (1 << (i + 4))) {
            // dbg_printf("search root: %zu\n", i);
            return i;
        }
    }
    return i;
}

/*
 *  insert block to root
 */
static void insert(block_t *block) {
    // dbg_printf("Insert %p ", (void*)block);
    dbg_assert(get_alloc(block) == false);
    size_t size = get_size(block);
    block->succ = NULL;
    block->pred = NULL;

    size_t num = search(size);

    if (heap_list[num].first == NULL) {
        heap_list[num].first = block;
    } else {
        // dbg_printf("%p (root %zu): \n", (void*)&heap_list[num], num);
        dbg_assert(heap_list[num].first->pred == NULL);
        block->succ = heap_list[num].first;
        heap_list[num].first->pred = block;
        block->pred = NULL;
        heap_list[num].first = block;
    }
}

/*
 *  delete block from root
 */
static void delete (block_t *block) {
    // dbg_printf("Delete %p ", (void*)block);
    // dbg_assert(get_alloc(block) == true);
    size_t size = get_size(block);

    size_t num = search(size);
    /*
     * only block on the root
     */
    if (block->pred == NULL && block->succ == NULL) {
        // dbg_printf("case1\n");
        heap_list[num].first = NULL;
    }
    /*
     * last block on the root
     */
    else if (block->pred != NULL && block->succ == NULL) {
        // print_freeList();
        // dbg_printf("case2, block->pred: %p\n", (void*)block->pred);
        block->pred->succ = NULL;
        block->pred = NULL;
    }
    /*
     * first block on the root
     */
    else if (block->pred == NULL && block->succ != NULL) {
        // print_freeList();
        // dbg_printf("case3, block->succ: %p\n", (void*)block->succ);
        heap_list[num].first = block->succ;
        block->succ->pred = NULL;
        block->succ = NULL;
    }
    /*
     * middle block
     */
    else if (block->pred != NULL && block->succ != NULL) {
        // dbg_printf("case4\n");
        block_t *succ = block->succ;
        block_t *pred = block->pred;
        block->pred->succ = succ;
        block->succ->pred = pred;
        block->succ = NULL;
        block->pred = NULL;
    }
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @param[in] block
 * @return
 */
static block_t *coalesce_block(block_t *block) {
    // dbg_printf("Coalescing......\n");
    block_t *prev = find_Fprev(block);
    block_t *next = find_next(block);

    bool prev_alloc = false;
    bool next_alloc = false;
    size_t size = get_size(block);
    size_t prev_size;
    size_t next_size;

    if (prev == NULL) {
        prev_alloc = true;
        prev_size = 0;
    } else {
        dbg_assert(prev != NULL);
        prev_size = get_size(prev);
        prev_alloc = get_alloc(prev);
    }

    if (next == NULL) {
        next_alloc = true;
        next_size = 0;
    } else {
        dbg_assert(next != NULL);
        next_size = get_size(next);
        next_alloc = get_alloc(next);
    }

    /* Case 1 */
    if (prev_alloc && next_alloc) {
        insert(block);
        return block;
    }

    /* Case 2 */
    else if (prev_alloc && !next_alloc) {
        size += next_size;
        write_block(block, size, false);
        insert(block);
        delete (next);
        return block;
    }

    /* Case 3 */
    else if (!prev_alloc && next_alloc) {
        delete (prev);
        size += prev_size;
        block = find_Fprev(block);
        write_block(block, size, false);
        insert(block);
        return block;
    }

    /* Case 4 */
    else {
        delete (prev);
        delete (next);
        size += next_size;
        size += prev_size;
        block = find_Fprev(block);
        write_block(block, size, false);
        insert(block);
        return block;
    }
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @param[in] size
 * @return
 */
static block_t *extend_heap(size_t size) {
    // dbg_printf("extend_heap\n");
    void *bp;

    // Allocate an even number of words to maintain alignment
    size = round_up(size, dsize);
    if ((bp = mem_sbrk((intptr_t)size)) == (void *)-1) {
        return NULL;
    }

    /*
     * TODO: delete or replace this comment once you've thought about it.
     * Think about what bp represents. Why do we write the new block
     * starting one word BEFORE bp, but with the same size that we
     * originally requested?
     */

    // Initialize free block header/footer
    block_t *block = payload_to_header(bp);
    write_block(block, size, false);

    // Create new epilogue header
    block_t *block_next = find_next(block);
    write_epilogue(block_next);

    // Coalesce in case the previous block was free
    block = coalesce_block(block);

    return block;
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @param[in] block
 * @param[in] asize
 */
static void split_block(block_t *block, size_t asize) {
    // dbg_printf("split block: %p\n", (void*)block);
    dbg_requires(get_alloc(block));
    /* TODO: Can you write a precondition about the value of asize? */

    size_t block_size = get_size(block);

    if ((block_size - asize) >= min_block_size) {
        block_t *block_next;
        write_header(block, asize, true);

        block_next = find_next(block);
        write_block(block_next, block_size - asize, false);

        insert(block_next);
    }

    dbg_ensures(get_alloc(block));
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @param[in] asize
 * @return
 */
// static block_t *find_fit(size_t asize) {
//     block_t *block;

//     for (block = heap_start; get_size(block) > 0; block = find_next(block)) {

//         if (!(get_alloc(block)) && (asize <= get_size(block))) {
//             return block;
//         }
//     }
//     return NULL; // no fit found
// }

/*
 * find_fit
 */
static block_t *find_fit(size_t asize) {
    // dbg_printf("find_fit:\n");
    size_t num = search(asize);
    block_t *block;

    while (num < seg_size) {
        block = heap_list[num].first;
        while (block) {
            // dbg_assert(!get_alloc(block));
            // print_block(block);
            if (get_size(block) >= asize) {
                return block;
            }
            block = block->succ;
        }
        num++;
    }
    return NULL;
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @param[in] line
 * @return
 */
bool mm_checkheap(int line) {
    // dbg_printf("begin checkheap\n");
    // print_heap();
    
    /*
     * TODO: Delete this comment!
     *
     * You will need to write the heap checker yourself.
     * Please keep modularity in mind when you're writing the heap checker!
     *
     * As a filler: one guacamole is equal to 6.02214086 x 10**23 guacas.
     * One might even call it...  the avocado's number.
     *
     * Internal use only: If you mix guacamole on your bibimbap,
     * do you eat it with a pair of chopsticks, or with a spoon?
     */
    
    block_t *block;
    size_t start_address = (size_t)(void *)heap_start;
    size_t firstbyte_address = (size_t)mem_heap_lo();
    size_t lastbyte_address = (size_t)mem_heap_hi();
    size_t total_size = 0;

    for (block = heap_start; get_size(block) > 0; block = find_next(block)) {
        size_t address = (size_t)(void *)block;
        total_size += get_size(block);
        // check block lie within heap boundaries
        if ((address < firstbyte_address) || (address > lastbyte_address)) {
            dbg_printf("block %p is not lie within heap boundaries\n", 
                        (void *)block);
            return false;
        }
        // block address alignment
        if (((address - start_address) % align) != 0) {
            dbg_printf("block %p is aligned incorrectly\n", (void *)block);
            return false;
        }
        // headers and footers have the same allocation value
        bool foot_alloc = extract_alloc(*header_to_footer(block));
        if (get_alloc(block) != foot_alloc) {
            dbg_printf("block %p has different header&footer alloc value\n",
                       (void *)block);
            return false;
        }
    }

    if (total_size > mem_heapsize()) {
        dbg_printf("block %p has different header&footer alloc value\n",
                    (void *)block);
        return false;
    }

    // no adjacent free blocks
    for (size_t i = 0; i < seg_size; i++) {
        block = heap_list[i].first;
        while (block != NULL) {
            // dbg_printf("checking freed block: %p\n", (void*)block);
            block_t *prev = find_Fprev(block);
            block_t *next = find_next(block);
            if (prev != NULL && !get_alloc(prev)) {
                dbg_printf("coalesce error: free block %p has freed prev\n",
                           (void *)block);
                return false;
            }
            if (next != NULL && !get_alloc(next)) {
                dbg_printf("coalesce error: free block %p has freed next\n",
                           (void *)block);
                return false;
            }

            // check free block pointers lie within heap boundaries
            if (block->pred) {
                block_t *pred = block->pred;
                size_t pred_address = (size_t)(void *)pred;
                if ((pred_address < firstbyte_address) || 
                    (pred_address > lastbyte_address)) {
                    dbg_printf("prev pointer of free block %p not \
                                lie within heap boundaries\n", 
                                (void *)block);
                    return false;
                }
            }
            if (block->succ) {
                block_t *succ = block->succ;
                size_t succ_address = (size_t)(void *)succ;
                if ((succ_address < firstbyte_address) || 
                    (succ_address > lastbyte_address)) {
                    dbg_printf("succ pointer of free block %p not \
                                lie within heap boundaries\n", 
                                (void *)block);
                    return false;
                }
            }

            /*
            * check blocks in each list bucket fall within bucket size range
            * (segregated list)
            */
            size_t size = get_size(block);
            if (size > (1 << (i + 4)) || size < (1 << (i + 3))) {
                dbg_printf("size of free block %p not fall within \
                            bucket size range\n", 
                            (void *)block);
                return false;
            }

            block = block->succ;
        }
    }

    // dbg_printf("I did not write a heap checker (called at line %d)\n", line);
    return true;
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @return
 */
bool mm_init(void) {
    // Create the initial empty heap
    heap_list = (root_t *)(mem_sbrk((2 + seg_size) * wsize));

    if (heap_list == (void *)-1) {
        return false;
    }

    for (size_t i = 0; i < seg_size; i++) {
        heap_list[i].first = NULL;
    }

    // Heap prologue (block footer)
    heap_list[seg_size].header = pack(0, true);
    // Heap epilogue (block header)
    heap_list[seg_size + 1].header = pack(0, true);

    // Heap starts with first "block header", currently the epilogue
    heap_start = (block_t *)&(heap_list[seg_size + 1].header);

    // Extend the empty heap with a free block of chunksize bytes
    if (extend_heap(chunksize) == NULL) {
        dbg_printf("mm_init returns FALSE because extend_heap == NULL\n");
        return false;
    }

    return true;
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @param[in] size
 * @return
 */
void *malloc(size_t size) {
    dbg_requires(mm_checkheap(__LINE__));
    // dbg_printf("MALLOC: %zu\n", size);

    size_t asize;      // Adjusted block size
    size_t extendsize; // Amount to extend heap if no fit is found
    block_t *block;
    void *bp = NULL;

    // Initialize heap if it isn't initialized
    if (heap_start == NULL) {
        if (!(mm_init())) {
            dbg_printf("Problem initializing heap. Likely due to sbrk");
            return NULL;
        }
    }

    // Ignore spurious request
    if (size == 0) {
        dbg_ensures(mm_checkheap(__LINE__));
        return bp;
    }

    // Adjust block size to include overhead and to meet alignment requirements
    asize = round_up(size + dsize, dsize);

    // Search the free list for a fit
    block = find_fit(asize);

    // dbg_printf("find fit result: ");
    // print_block(block);

    // If no fit is found, request more memory, and then and place the block
    if (block == NULL) {
        // Always request at least chunksize
        extendsize = max(asize, chunksize);
        block = extend_heap(extendsize);
        // extend_heap returns an error
        if (block == NULL) {
            return bp;
        }
    }

    // The block should be marked as free
    dbg_assert(!get_alloc(block));

    // Mark block as allocated
    size_t block_size = get_size(block);
    write_header(block, block_size, true);
    delete (block);
    
    // Try to split the block if too large
    split_block(block, asize);

    bp = header_to_payload(block);

    // print_heap();
    // print_freeList();
    dbg_ensures(mm_checkheap(__LINE__));
    return bp;
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @param[in] bp
 */
void free(void *bp) {
    dbg_requires(mm_checkheap(__LINE__));
    // dbg_printf("FREE: ");

    if (bp == NULL) {
        return;
    }

    block_t *block = payload_to_header(bp);
    size_t size = get_size(block);
    // print_block(block);

    // The block should be marked as allocated
    dbg_assert(get_alloc(block));

    // Mark the block as free
    write_block(block, size, false);

    // Try to coalesce the block with its neighbors
    coalesce_block(block);

    dbg_ensures(mm_checkheap(__LINE__));
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @param[in] ptr
 * @param[in] size
 * @return
 */
void *realloc(void *ptr, size_t size) {
    block_t *block = payload_to_header(ptr);
    size_t copysize;
    void *newptr;

    // If size == 0, then free block and return NULL
    if (size == 0) {
        free(ptr);
        return NULL;
    }

    // If ptr is NULL, then equivalent to malloc
    if (ptr == NULL) {
        return malloc(size);
    }

    // Otherwise, proceed with reallocation
    newptr = malloc(size);

    // If malloc fails, the original block is left untouched
    if (newptr == NULL) {
        return NULL;
    }

    // Copy the old data
    copysize = get_payload_size(block); // gets size of old payload
    if (size < copysize) {
        copysize = size;
    }
    memcpy(newptr, ptr, copysize);

    // Free the old block
    free(ptr);

    return newptr;
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @param[in] elements
 * @param[in] size
 * @return
 */
void *calloc(size_t elements, size_t size) {
    void *bp;
    size_t asize = elements * size;

    if (elements == 0) {
        return NULL;
    }
    if (asize / elements != size) {
        // Multiplication overflowed
        return NULL;
    }

    bp = malloc(asize);
    if (bp == NULL) {
        return NULL;
    }

    // Initialize all bits to 0
    memset(bp, 0, asize);

    return bp;
}

/*
 *****************************************************************************
 * Do not delete the following super-secret(tm) lines!                       *
 *                                                                           *
 * 53 6f 20 79 6f 75 27 72 65 20 74 72 79 69 6e 67 20 74 6f 20               *
 *                                                                           *
 * 66 69 67 75 72 65 20 6f 75 74 20 77 68 61 74 20 74 68 65 20               *
 * 68 65 78 61 64 65 63 69 6d 61 6c 20 64 69 67 69 74 73 20 64               *
 * 6f 2e 2e 2e 20 68 61 68 61 68 61 21 20 41 53 43 49 49 20 69               *
 *                                                                           *
 * 73 6e 27 74 20 74 68 65 20 72 69 67 68 74 20 65 6e 63 6f 64               *
 * 69 6e 67 21 20 4e 69 63 65 20 74 72 79 2c 20 74 68 6f 75 67               *
 * 68 21 20 2d 44 72 2e 20 45 76 69 6c 0a c5 7c fc 80 6e 57 0a               *
 *                                                                           *
 *****************************************************************************
 */
