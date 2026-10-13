#+feature dynamic-literals
package main
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

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
build_recur_arr :: proc(filepath: string) -> [dynamic]recur_arr {
	data, err := os.read_entire_file(filepath, context.allocator)
	if err != nil {
		fmt.println(err)
		return nil
	}
	defer delete(data, context.allocator)
	curr_arr: [dynamic]recur_arr
	arr_stack: [dynamic]^[dynamic]recur_arr

	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		// for every character in each line
		for c, i in line {
			char_str := line[i:i + utf8.rune_size(c)]
			if is_opening_bracket(c) {
				new_arr := new([dynamic]recur_arr)
				curr_arr = new_arr^
				append(&arr_stack, new_arr)
			}

			if is_closing_bracket(c) {
				curr_arr = pop(&arr_stack)^
			}

			if val, ok := strconv.parse_int(char_str); ok {
				fmt.println(val)
			}
		}
	}

	return curr_arr
}


main :: proc() {
	// root_arr := [dynamic]recur_arr{12, 23}
	// top_arr := [dynamic]recur_arr{42, 13}
	// arr_stack: [dynamic]^[dynamic]recur_arr
	// append(&arr_stack, &root_arr)
	// append(&arr_stack, &top_arr)

	// curr_arr := pop(&arr_stack)
	// append(curr_arr, 44)

	// new_arr := new([dynamic]recur_arr)
	// append(&arr_stack, new_arr)

	// fmt.println(new_arr)
	// fmt.println(arr_stack)
	// fmt.println(top_arr[:])
	arr := build_recur_arr("./data.json")
	fmt.println(arr)
}
