#+feature dynamic-literals
package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

recur_arr :: union {
	int,
	[dynamic]recur_arr,
}

build_recur_arr :: proc(filepath: string) -> [dynamic]recur_arr {
	data, err := os.read_entire_file(filepath, context.allocator)
	if err != nil {
		fmt.println(err)
		return nil
	}
	defer delete(data, context.allocator)

	// 1. Root container allocation
	root := make([dynamic]recur_arr)

	// 2. Stack of pointers to active dynamic arrays
	arr_stack: [dynamic]^[dynamic]recur_arr
	defer delete(arr_stack)

	// Push address of root onto the stack
	append(&arr_stack, &root)

	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		i := 0
		for i < len(line) {
			ch := line[i]

			// Skip whitespace & commas
			if ch == ' ' || ch == '\t' || ch == ',' || ch == '\r' {
				i += 1
				continue
			}

			// Get active array pointer from top of stack
			curr_arr := arr_stack[len(arr_stack) - 1]

			// Open bracket: create child array, append to current, push to stack
			if ch == '[' {
				// If we are at root level (stack length 1), we treat the first '['
				// as the opening bracket for root itself.
				if len(arr_stack) == 1 && len(root) == 0 {
					i += 1
					continue
				}

				child_arr := make([dynamic]recur_arr)
				append(curr_arr, child_arr)

				// Get pointer to child dynamic array stored inside the union element
				child_ptr := &curr_arr[len(curr_arr) - 1].([dynamic]recur_arr)
				append(&arr_stack, child_ptr)

				i += 1
				continue
			}

			// Close bracket: pop active array from stack
			if ch == ']' {
				if len(arr_stack) > 1 {
					pop(&arr_stack)
				}
				i += 1
				continue
			}

			// Numbers: append integer to active array
			if (ch >= '0' && ch <= '9') || ch == '-' {
				start := i
				if ch == '-' {
					i += 1
				}
				for i < len(line) && (line[i] >= '0' && line[i] <= '9') {
					i += 1
				}

				num_str := line[start:i]
				if val, ok := strconv.parse_int(num_str); ok {
					append(curr_arr, val)
				}
				continue
			}

			i += 1
		}
	}

	return root
}

main :: proc() {
	arr := build_recur_arr("./data.json")
	fmt.println(arr)
}
