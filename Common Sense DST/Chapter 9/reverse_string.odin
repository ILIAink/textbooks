package main
import "core:fmt"
import "core:strings"
import st "stack"

// using a stack
reverse_string :: proc(input: string) -> string {
	stack := st.Stack{}
	result := strings.builder_make()
	for c in input {
		st.push(&stack, c)
	}

	for len(stack.data) != 0 {
		val := st.pop(&stack)
		strings.write_rune(&result, val)
	}

	return strings.to_string(result)
}
