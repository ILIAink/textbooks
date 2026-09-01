package stack

Stack :: struct {
	data: [dynamic]rune,
}

push :: proc(stack: ^Stack, val: rune) {
	append(&stack.data, val)
}

pop :: proc(stack: ^Stack) -> rune {
	if len(stack.data) == 0 {
		return 0
	}

	last := stack.data[len(stack.data) - 1]
	resize(&stack.data, len(stack.data) - 1)

	return last
}

peek :: proc(stack: ^Stack) -> rune {
	return stack.data[len(stack.data) - 1]
}
