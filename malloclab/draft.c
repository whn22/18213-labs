/*
 *  删除块,清理指针
 */
void delete(void *bp)
{
    /* 块大小 */
    size_t size = GET_SIZE(HDRP(bp));
    /* 根据块大小找到头节点位置 */
    int num = search(size);
    /* 
     * 唯一节点,后继为null,前驱为null 
     * 头节点设为null
     */
    if (GET_PRE(bp) == NULL && GET_SUC(bp) == NULL) { 
        PUT(heap_start + wsize * num, NULL);
    } 
    /* 
     * 最后一个节点 
     * 前驱的后继设为null
     */
    else if (GET_PRE(bp) != NULL && GET_SUC(bp) == NULL) {
        PUT(GET_PRE(bp) + 1, NULL);
    } 
    /* 
     * 第一个结点 
     * 头节点设为bp的后继
     */
    else if (GET_SUC(bp) != NULL && GET_PRE(bp) == NULL){
        PUT(heap_start + wsize * num, GET_SUC(bp));
        PUT(GET_SUC(bp), NULL);
    }
    /* 
     * 中间结点 
     * 前驱的后继设为后继
     * 后继的前驱设为前驱
     */
    else if (GET_SUC(bp) != NULL && GET_PRE(bp) != NULL) {
        PUT(GET_PRE(bp) + 1, GET_SUC(bp));
        PUT(GET_SUC(bp), GET_PRE(bp));
    }
}