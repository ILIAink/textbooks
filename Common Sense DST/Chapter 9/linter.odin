package main
import "core:fmt"
import "core:slice"
import st "stack"

OPENING_BRACE :: [3]rune{'(', '{', '['}
CLOSING_BRACE :: [3]rune{')', '}', ']'}

get_closing_brace :: proc(opening_brace: rune) -> rune {
	switch opening_brace {
	case '(':
		return ')'

	case '{':
		return '}'

	case '[':
		return ']'

	}

	return 0
}

is_opening_brace :: proc(brace: rune) -> bool {
	arr := OPENING_BRACE
	return slice.contains(arr[:], brace)
}

is_closing_brace :: proc(brace: rune) -> bool {
	arr := CLOSING_BRACE
	return slice.contains(arr[:], brace)
}


valid_parenthesis :: proc(input: string, stack: ^st.Stack) -> bool {
	for c in input {
		if is_opening_brace(c) {
			st.push(stack, c)
		} else if is_closing_brace(c) {
			popped_brace := st.pop(stack)
			if c != get_closing_brace(popped_brace) {
				return false
			}
		}

	}

	return len(stack.data) == 0
}
