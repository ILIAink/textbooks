## Chapter Idea
Stacks and Queues are used to create 
### Stacks
Same way that arrays work, except they have the following constraints:
- Data can only be inserted at the end of the stack
- Data can be deleted only from the end of the stack
- Only the last element of the stack can be read
They operations can be described as: LIFO - Last in, first out


#### Use Cases
Valid Parentheses: 
1. Opening brace that doesn't have an equal 
2. A closing brace that doesn't have a corresponding opening brace
3. Closing brace is not the same *type* of brace as the immediately preceding opening brace

Undo Button: 
- You can save the keystrokes of the user by pushing them onto the stack, and if the do `Cmd + Z`, you can simply pop it from the stack and remove it from being read. 

### Queues
Similar to a stack, but processes data differently:
- Data can be inserted only at the end of the queue (same as stack)
- Data can only be deleted from the front of the queue (opposite from stack)
- Only the element at the front of a queue can be read (opposite from stack)

#### Use Cases
- Print jobs
- Background workers in applications
- Queue for a call system
### Exercises

1. If you were writing software for a call center that places callers on hold and then assigns them to "the next available representative," would you use a stack or a queue? 
	- Queue
2. If you pushed numbers onto a stack in the following order: 1, 2, 3, 4, 5, 6, and then popped two items, which number would you be able to read from the stack?
	- Pop 6
	- Pop 5
	- Peeking would read 4
3. If you inserted numbers into a queue in the following order: 1, 2, 3, 4, 5, 6, and then dequeued two items, which number would you be able to read from the queue? 
	- Dequeue 1
	- Dequeue 2
	- Peeking would read 3
4. Write a function that uses a stack to reverse a string. (For example, "abcde" would become "edcba".) You can work with our earlier implementation of the Stack class.
```odin
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
```