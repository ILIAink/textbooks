### Tail Recursion
```odin
tail_factorial :: proc(n: int, i: int = 1, product: int = 1) -> int {
	if i > n {return product}
	return tail_factorial(n, i + 1, product * i)
}
```

or a bit simpler, with an accumulator parameter:
```odin
better_tail_factorial :: proc(n: int, acc: int = 1) -> int {
	if n < 1 {return acc}
	return better_tail_factorial(n - 1, n * acc)
}
```

In the examples above, instead of using a top-down approach we are simply using a bottom up approach. Though a better term for this is simply tail recursion. As in the second example, we are going from $n$ to $0$. Tail recursion is defined purely by position, not by direction. As long as the recursive call is the absolute last thing the function evaluates, it is tail-recursive.

**The Benefit:**
In standard (non-tail) recursion, each function call leaves unfinished business on the stack. For example, if you do $n * factorial(n - 1)$, the computer has to pause, keep the current value of n in memory, wait for the recursive call to finish, and then do the multiplication. Because it has to remember all those pending operations, the stack grows taller and taller.
In tail recursion, there is no pending work. By the time you make the recursive call, all the intermediate results are already bundled up into your arguments (like an accumulator). The current function frame has literally nothing left to do.


### Top-Down Recursion
This line of code makes its calculation based on factorial(number - 1). When we write this line of code, do we have to understand how the factorial function it’s calling works? Technically, we don’t. Whenever we write code that calls another function, we assume that the function will return the correct value without necessarily understanding how its internals work.

Here as well, when we calculate our answer based on calling the factorial function, we don’t need to understand how the factorial function works; we can just expect it to return the correct result. Of course, the weird part is that we’re the ones writing the factorial function! This line of code exists within the factorial function itself. But that’s what is so great about top-down thinking: in a way, we can solve the problem without even knowing how to solve the problem.


#### Top-Down Thought Process
1. Imagine the function you're writing has already been implemented by someone else.
2. Identify the subproblem of the problem. 
3. See what happens when you call the function on the subproblem and go from there.

#### Sum
The first thing we’ll do is imagine that the sum function has already been implemented. Admittedly, this takes a certain suspension of disbelief, since we know that we’re in the middle of writing this function as we speak! But let’s try to let go and pretend that the sum function already works.

Next, let’s identify the subproblem. This can be more of an art than a science,
but practice will help you get better at this. In our case, we can say that the
subproblem is the array, `[2, 3, 4, 5]`—that is, all the numbers from the array
save the first one.

To solve our problem of finding the sum of `[1, 2, 3, 4, 5]` then, we can just add the first number, 1, to the result of `sum([2, 3, 4, 5])`. In pseudocode, we’d write something like this:
`return array[0] + sum(the remainder of the array)`

In odin, we can do the following `return arr[0] + sum_factorial(arr[1:len(arr)]` (This is non inclusive, so it goes up to `len(arr)`, but won't include it. And we are done. We only need to worry about the base case, when the array just has one element, we just return it. It will look something like this:
```
sum_factorial :: proc(arr: []int) -> int {
	if len(arr) == 1 {
		return arr[0]
	}

	return arr[0] + sum_factorial(arr[1:len(arr)])
}
```

In the example above, at each step we take the first element of the array, and then call the function again by creating an array that includes the next element until the remainder of the array. If we keep doing this until we reach the base case, we have our sum.

Let's walk through a smaller array: `[1, 2, 3]`
- We call `sum_factorial([1, 2, 3])`
- Then we will call `1 + sum_factorial([2, 3])`
- Then it will go to `2 + sum_factorial([3])`
- Now that there is only, one element left in the array, we return `3`
- So now if we go back and put it all together we get `1 + 2 + 3` which will yield `6`, our answer. 


