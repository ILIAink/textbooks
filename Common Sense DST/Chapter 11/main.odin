#+feature dynamic-literals
package main

import "core:fmt"

main :: proc() {
	// arr: [dynamic]int = {1, 2, 3, 4}
	// double_array(arr)
	// fmt.println(arr)
	// fmt.println(tail_factorial_one(5))
	// arr := [5]
	// fmt.println(sum_factorial([]int{1, 2, 3}))
	// fmt.println(reverse_string("abcde"))
	// fmt.println(count_x("abxbxbx"))
	fmt.println(climbing_stairs(5))
}

climbing_stairs :: proc(num_stairs: int) -> int {
	if num_stairs < 0 {
		return 0
	}

	if num_stairs == 1 || num_stairs == 0 {
		return 1
	}

	return(
		climbing_stairs(num_stairs - 3) +
		climbing_stairs(num_stairs - 2) +
		climbing_stairs(num_stairs - 1) \
	)
}

count_x :: proc(s: string) -> int {
	if len(s) == 0 {
		return 0
	}

	if s[0] == 'x' {
		return 1 + count_x(s[1:len(s)])
	} else {
		return count_x(s[1:len(s)])
	}
}

// reverse_string :: proc(s: string) -> rune {
// 	// See python file
// }

sum_factorial :: proc(arr: []int) -> int {
	if len(arr) == 1 {
		return arr[0]
	}

	return arr[0] + sum_factorial(arr[1:len(arr)])
}

tail_factorial :: proc(n: int, i: int = 1, product: int = 1) -> int {
	if i > n {return product}
	return tail_factorial(n, i + 1, product * i)
}

tail_factorial_one :: proc(n: int, acc: int = 1) -> int {
	if n < 1 {return acc}
	return tail_factorial_one(n - 1, n * acc)
}

double_array :: proc(arr: [dynamic]int, index: int = 0) {
	if (index >= len(arr)) {
		return
	}

	arr[index] = arr[index] * 2
	double_array(arr, index + 1)
}
