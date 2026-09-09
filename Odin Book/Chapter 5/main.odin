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
	val: My_Union
	val = Person {
		age    = 32,
		health = 100,
	}

	// switch v in val {
	// case int:
	// 	fmt.println("you're an int")
	// case f32:
	// 	fmt.println("you're a float")
	// case Person:
	// 	fmt.println("you're a person struct")
	// }
	//
	//
	if person_val, ok := &val.(Person); ok {
		person_val.age = 42
	}


	fmt.println(val)

}
