package main

import "core:fmt"

Person :: struct {
	age:    int,
	health: int,
}

My_Union :: union {
	f32,
	int,
	Person,
}

main :: proc() {
	val: My_Union = 12.2
	fmt.println()
}
