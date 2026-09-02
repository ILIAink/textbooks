package queue

Queue :: struct {
	data: [dynamic]string,
}


enqueue :: proc(queue: ^Queue, document: string) {
	append(&queue.data, document)
}


dequeue :: proc(queue: ^Queue) -> string {
	to_dequeue := queue.data[0]
	ordered_remove(&queue.data, 0)
	return to_dequeue
}

peek :: proc(queue: ^Queue) -> string {
	return queue.data[0]
}
