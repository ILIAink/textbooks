package main
import "core:fmt"
import q "queue"

add_job :: proc(print_queue: ^q.Queue, document: string) {
	q.enqueue(print_queue, document)
}

run_jobs :: proc(print_queue: ^q.Queue) {
	for len(print_queue.data) != 0 {
		fmt.println("Now working on: ", q.dequeue(print_queue))
	}
}

main :: proc() {
	print_queue := q.Queue{}
	add_job(&print_queue, "document 1")
	add_job(&print_queue, "document 2")
	add_job(&print_queue, "document 3")
	run_jobs(&print_queue)
	fmt.println(print_queue.data[:])
}
