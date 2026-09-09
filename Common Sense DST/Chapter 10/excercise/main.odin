#+feature dynamic-literals
package main
import "core:fmt"
import "core:os"
import "core:strings"

recur_arr :: union {
	int,
	[dynamic]recur_arr,
}

is_opening_bracket :: proc(c: rune) -> bool {
	return c == '['
}

is_closing_bracket :: proc(c: rune) -> bool {
	return c == ']'
}

/*
1. Read contents of data.json
2. Initialize Root: Create your main root dynamic array (my_arr).
3. Initialize Stack: Create a stack of pointers ([dynamic]^recur_arr) and push &my_arr onto it.
4. Continue doing that as you see open brackets
5. If you see closing bracket, stop appending to top-most array that has been pushed to the stack
6. Keep going until there are no lines to read and the stack is empty
*/
build_recur_arr :: proc(filepath: string) {
	data, err := os.read_entire_file(filepath, context.allocator)
	if err != nil {
		fmt.println(err)
		return
	}
	defer delete(data, context.allocator)

	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		// for every character in each line
		for c in line {
			if is_opening_bracket(c) {

			}

			if is_closing_bracket(c) {

			}


		}
	}
}


main :: proc() {
	// my_arr: [dynamic]recur_arr
	// append(&my_arr, 1)
	// append(&my_arr, 2)
	// append(&my_arr, [dynamic]recur_arr{3, 4, 5})
	// append(&my_arr, [dynamic]recur_arr{6, 7, 8, [dynamic]recur_arr{9, 10, 11}})


	// // for item in my_arr {
	// // 	fmt.println(item)
	// // }
	// //
	// fmt.println(my_arr[:])
	build_recur_arr("./data.json")
}
