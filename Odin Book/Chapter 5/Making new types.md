### 5.1 Structs


### 5.2 Enums and switch


### 5.3 Unions
```odin
Person :: struct {
	age:    int,
	health: int,
}

My_Union :: union {
	f32,
	int,
	Person,
}
```

> The My_Union type will only use as much memory as the biggest variant. It can only contain one of the variants at a time, so it can use the same block of memory for all of them. You can think of it as three different variables that all share the same memory, but you're only allowed to use one of them at a time.

![](./assets/file-20260902134013146.png)

You can check to see if a union is of a ==certain type==: 
```odin
val: My_Union
val = Person {
	age = 24
	health = 100
}

val_person, val_person_ok := val.(Person) // returns the value it holds, returns true

val_person, val_person_ok := val.(f32) // returns 0, returns false
```

Changing the value of the type that the union is holding using this special type of if-statement:
```odin
if person_val, ok := &val.(Person); ok {
	person_val.age = 42
}

fmt.println(val) // prints Person{age = 42, health = 100}
```




