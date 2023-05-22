#include <pthread.h>
#include <stdatomic.h>
#include "thread_chain.h"

atomic_int global_counter = 0;

void *my_thread(void *data) {
    if (global_counter < 50){
        thread_hello();
        global_counter += 1;
        pthread_t new_thread;
        pthread_create(&new_thread, NULL, my_thread, NULL);
        pthread_join(new_thread, NULL);
    }
    return NULL;
}

void my_main(void) {
    pthread_t thread_handle;
    pthread_create(&thread_handle, NULL, my_thread, NULL);

    pthread_join(thread_handle, NULL);
}
