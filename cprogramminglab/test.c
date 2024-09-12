// Consider the following linked list structure:

typedef struct list_ele {
    /**
     * @brief Pointer to a char array containing a string value.
     */
    char *value;

    /**
     * @brief Pointer to the next element in the linked list.
     */
    struct list_ele *next;
} list_ele_t;

/**
 * @brief Queue structure representing a list of elements
 */
typedef struct {
    list_ele_t *head;
    list_ele_t *tail;
    size_t size;
} queue_t;

// Please write the c function "queue_reverse" based on the description.
/**
 * @brief Reverse the elements in a queue
 *
 * This function does not allocate or free any list elements, i.e. it does
 * not call malloc or free, including inside helper functions. Instead, it
 * rearranges the existing elements of the queue.
 *
 * @param[in] q The queue to reverse
 */
void queue_reverse(queue_t *q) {
    if (q == NULL) return;
    list_ele_t *tail = q->head;
    while (q->head != q->tail) {
        list_ele_t *before = q->head;
        list_ele_t *after = q->head->next->next;
        q->head = q->head->next;
        q->head->next = before;
        q->head->next->next = after;
    }
    q->tail = tail;
}