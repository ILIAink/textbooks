package main

import "core:fmt"
import "core:mem"
import vmem "core:mem/virtual"
import "core:os"

count_down :: proc(num: int) {
	if (num <= 1) {
		fmt.println(num)
		return
	}
	count_down(num - 1)
	fmt.println(num)
}


list_dir_deep :: proc(curr_dir: string, alloc: mem.Allocator) {
	list_of_dirs, err := os.read_all_directory_by_path(curr_dir, alloc)
	for dir in list_of_dirs {
		if os.is_directory(dir.fullpath) {
			fmt.println(dir.name)
			list_dir_deep(dir.fullpath, alloc)
		}
	}

}

low_high :: proc(low, high: int) {
	if low > high {
		return
	}
	fmt.println(low)
	low_high(low + 2, high)
}

low_high_sum :: proc(low, high: int) -> int {
	if (low >= high) {
		return low
	}
	return high + low_high_sum(low, high - 1)
}


main :: proc() {
	arena: vmem.Arena
	arena_err := vmem.arena_init_growing(&arena)
	ensure(arena_err == nil)
	arena_alloc := vmem.arena_allocator(&arena)
	curr_dir, err := os.get_working_directory(arena_alloc)
	fmt.println(curr_dir)

	fmt.println(low_high_sum(1, 10))
}
