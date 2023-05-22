////////////////////////////////////////////////////////////////////////////////
// COMP1521 22T1 --- Assignment 2: `Allocator', a simple sub-allocator        //
// <https://www.cse.unsw.edu.au/~cs1521/22T1/assignments/ass2/index.html>     //
//                                                                            //
// Written by Yikai Qin (z5378608) on 2022/4/20.                              //
//                                                                            //
// 2021-04-06   v1.0    Team COMP1521 <cs1521 at cse.unsw.edu.au>             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "allocator.h"

// DO NOT CHANGE CHANGE THESE #defines

/** minimum total space for heap */
#define MIN_HEAP 4096

/** minimum amount of space to split for a free chunk (excludes header) */
#define MIN_CHUNK_SPLIT 32

/** the size of a chunk header (in bytes) */
#define HEADER_SIZE (sizeof(struct header))

/** constants for chunk header's status */
#define ALLOC 0x55555555
#define FREE 0xAAAAAAAA

// ADD ANY extra #defines HERE

// DO NOT CHANGE these struct defintions

typedef unsigned char byte;

/** The header for a chunk. */
typedef struct header {
    uint32_t status; /**< the chunk's status -- shoule be either ALLOC or FREE */
    uint32_t size;   /**< number of bytes, including header */
    byte     data[]; /**< the chunk's data -- not interesting to us */
} header_type;


/** The heap's state */
typedef struct heap_information {
    byte      *heap_mem;      /**< space allocated for Heap */
    uint32_t   heap_size;     /**< number of bytes in heap_mem */
    byte     **free_list;     /**< array of pointers to free chunks */
    uint32_t   free_capacity; /**< maximum number of free chunks (maximum elements in free_list[]) */
    uint32_t   n_free;        /**< current number of free chunks */
} heap_information_type;

// Footnote:
// The type unsigned char is the safest type to use in C for a raw array of bytes
//
// The use of uint32_t above limits maximum heap size to 2 ** 32 - 1 == 4294967295 bytes
// Using the type size_t from <stdlib.h> instead of uint32_t allowing any practical heap size,
// but would make struct header larger.


// DO NOT CHANGE this global variable
// DO NOT ADD any other global  variables

/** Global variable holding the state of the heap */
static struct heap_information my_heap;

// ADD YOUR FUNCTION PROTOTYPES HERE
void remove_free_chunk(uint32_t position);
void insert_free_chunk(void *ptr, int position);
void split_free_chunk(void *ptr, uint32_t position, uint32_t offset, uint32_t free_size);
void merge_free_chunk();

// Initialise my_heap
int init_heap(uint32_t size) {

    if (size < 4096) {
        my_heap.heap_size = 4096;
    } else if ((size % 4) != 0) {
        while ((size % 4) != 0) {
            size++;
        }
        my_heap.heap_size = size;
    } else {
        my_heap.heap_size = size;
    }

    if ((my_heap.heap_mem = malloc(size)) == NULL){
        return -1;
    }

    int list_size = my_heap.heap_size / HEADER_SIZE;
    if ((my_heap.free_list = calloc(list_size, HEADER_SIZE)) == NULL){
        return -1;
    }
    for (int i = 0; i < list_size; i++) {
        my_heap.free_list[i] = NULL;
    } 

    my_heap.n_free = 1;
    my_heap.free_capacity = list_size;
    struct header *first_header = (struct header *)(my_heap.heap_mem);
    first_header->status = FREE;
    first_header->size = my_heap.heap_size;
    my_heap.free_list[0] = (byte*)(first_header);
    return 0; 
}


// Allocate a chunk of memory large enough to store `size' bytes
void *my_malloc(uint32_t size) {

    if (size < 1){
        return NULL;
    } else if ((size % 4) != 0) {
        while ((size % 4) != 0) {
            size++;
        }
    }
    uint32_t need_size = size + HEADER_SIZE;
    uint32_t chunk_scope = size + HEADER_SIZE + MIN_CHUNK_SPLIT;
    uint32_t subscript = 0;
    struct header *ptr = NULL;
    while (my_heap.free_list[subscript] != NULL){
        ptr = (struct header *)(my_heap.free_list[subscript]);
        if (ptr->size >= need_size){
            if (ptr->size < chunk_scope){
                ptr->status = ALLOC;
                remove_free_chunk(subscript);
            } else {
                uint32_t free_size = ptr->size - need_size;
                ptr->status = ALLOC;
                ptr->size = need_size;
                uint32_t offset = need_size;
                split_free_chunk(ptr, subscript, offset, free_size);
            }
            break;
        }
        subscript += 1;
    }
    byte *head_ptr = (byte*)(ptr);
    byte *first_byte = (byte*)(head_ptr + HEADER_SIZE);
    return first_byte; 
}


// Deallocate chunk of memory referred to by `ptr'
void my_free(void *ptr) {
    if (ptr == NULL){
        fprintf(stderr, "Attempt to free unallocated chunk\n");
        exit(1);
    }
    struct header *aim_chunk = (struct header *)(ptr - HEADER_SIZE);
    if (aim_chunk->status != ALLOC) {
        fprintf(stderr, "Attempt to free unallocated chunk\n");
        exit(1);
    }                                  
    int64_t head_offset = heap_offset(aim_chunk);
    uint32_t index = 0;
    uint32_t end_index = my_heap.n_free - 1; 
    byte *ptr_end = my_heap.free_list[end_index];
    aim_chunk->status = FREE;

    // Free chunk is in the end of the free_list
    if (head_offset > heap_offset(ptr_end)){
        my_heap.free_list[end_index + 1] = (byte*)(aim_chunk);
        my_heap.n_free += 1;

    } else {
        while (my_heap.free_list[index] != NULL){
        byte *free_list_ptr = my_heap.free_list[index];
        if (head_offset < heap_offset(free_list_ptr)){
            insert_free_chunk(aim_chunk, index);
            break;
        }
        index += 1;
        }
    }
    merge_free_chunk();
}


// DO NOT CHANGE CHANGE THiS FUNCTION
//
// Release resources associated with the heap
void free_heap(void) {
    free(my_heap.heap_mem);
    free(my_heap.free_list);
}


// DO NOT CHANGE CHANGE THiS FUNCTION

// Given a pointer `obj'
// return its offset from the heap start, if it is within heap
// return -1, otherwise
// note: int64_t used as return type because we want to return a uint32_t bit value or -1
int64_t heap_offset(void *obj) {
    if (obj == NULL) {
        return -1;
    }
    int64_t offset = (byte *)obj - my_heap.heap_mem;
    if (offset < 0 || offset >= my_heap.heap_size) {
        return -1;
    }

    return offset;
}


// DO NOT CHANGE CHANGE THiS FUNCTION
//
// Print the contents of the heap for testing/debugging purposes.
// If verbosity is 1 information is printed in a longer more readable form
// If verbosity is 2 some extra information is printed
void dump_heap(int verbosity) {

    if (my_heap.heap_size < MIN_HEAP || my_heap.heap_size % 4 != 0) {
        printf("ndump_heap exiting because my_heap.heap_size is invalid: %u\n", my_heap.heap_size);
        exit(1);
    }

    if (verbosity > 1) {
        printf("heap size = %u bytes\n", my_heap.heap_size);
        printf("maximum free chunks = %u\n", my_heap.free_capacity);
        printf("currently free chunks = %u\n", my_heap.n_free);
    }

    // We iterate over the heap, chunk by chunk; we assume that the
    // first chunk is at the first location in the heap, and move along
    // by the size the chunk claims to be.

    uint32_t offset = 0;
    int n_chunk = 0;
    while (offset < my_heap.heap_size) {
        struct header *chunk = (struct header *)(my_heap.heap_mem + offset);

        char status_char = '?';
        char *status_string = "?";
        switch (chunk->status) {
        case FREE:
            status_char = 'F';
            status_string = "free";
            break;

        case ALLOC:
            status_char = 'A';
            status_string = "allocated";
            break;
        }

        if (verbosity) {
            printf("chunk %d: status = %s, size = %u bytes, offset from heap start = %u bytes",
                    n_chunk, status_string, chunk->size, offset);
        } else {
            printf("+%05u (%c,%5u) ", offset, status_char, chunk->size);
        }

        if (status_char == '?') {
            printf("\ndump_heap exiting because found bad chunk status 0x%08x\n",
                    chunk->status);
            exit(1);
        }

        offset += chunk->size;
        n_chunk++;

        // print newline after every five items
        if (verbosity || n_chunk % 5 == 0) {
            printf("\n");
        }
    }

    // add last newline if needed
    if (!verbosity && n_chunk % 5 != 0) {
        printf("\n");
    }

    if (offset != my_heap.heap_size) {
        printf("\ndump_heap exiting because end of last chunk does not match end of heap\n");
        exit(1);
    }

}

// ADD YOUR EXTRA FUNCTIONS HERE


// remove a free chunk form free chunk list
void remove_free_chunk(uint32_t position) { 

    for (int c = position; c < (my_heap.free_capacity - 1); c++){
        my_heap.free_list[c] = my_heap.free_list[c + 1];
    }
    my_heap.free_list[my_heap.free_capacity - 1] = NULL;
    my_heap.n_free -= 1;
}


// split a free chunk into two part(one is allocated part, another is new free chunk)
void split_free_chunk(void *ptr, uint32_t position, uint32_t offset, uint32_t free_size) {

    struct header *sp_chunk = (struct header *)(ptr + offset);
    sp_chunk->status = FREE;
    sp_chunk->size = free_size;
    my_heap.free_list[position] = (byte*)(sp_chunk);
}


// insert a new free chunk into free chunk list
void insert_free_chunk(void *ptr, int position) {
    uint32_t end_index = my_heap.n_free - 1;
    
    for (int c = end_index; c >= position; c--){
        my_heap.free_list[c + 1] = my_heap.free_list[c];
    } 
    my_heap.free_list[position] = (byte*)(ptr);
    my_heap.n_free += 1;
}


// merge adjacent free chunk into a whole
void merge_free_chunk() {

    uint32_t subscript = 0;
    while (my_heap.free_list[subscript + 1] != NULL){
        struct header *front_chunk = (struct header *)(my_heap.free_list[subscript]);
        struct header *next_chunk = (struct header *)(my_heap.free_list[subscript + 1]);
        int64_t front_chunk_tail = heap_offset(my_heap.free_list[subscript]) + front_chunk->size;
        int64_t next_chunk_head = heap_offset(my_heap.free_list[subscript + 1]);

        if (front_chunk_tail == next_chunk_head){
            front_chunk->size += next_chunk->size;
            remove_free_chunk(subscript + 1);
            subscript -= 1;
        }
        subscript += 1;
    }
}


