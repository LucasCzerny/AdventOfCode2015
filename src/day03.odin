package aoc

import "core:fmt"
import "core:os"
import "core:strings"
import "core:testing"
import "core:time"

solve_day03_part1 :: proc(input: string) -> int {
	tree := new(Tree_Node)
	tree.value = {0, 0}
	defer free_tree(tree)

	current_position := [2]int{0, 0}
	unique_positions_counter := 1

	for action in input {
		switch (action) {
		case '<':
			current_position.x -= 1
		case '>':
			current_position.x += 1
		case '^':
			current_position.y -= 1
		case 'v':
			current_position.y += 1
		}

		is_duplicate := insert_into_tree(tree, current_position)
		if !is_duplicate {
			unique_positions_counter += 1
		}
	}

	return unique_positions_counter
}

solve_day03_part2 :: proc(input: string) -> int {
	tree := new(Tree_Node)
	tree.value = {0, 0}
	defer free_tree(tree)

	current_positions := [2][2]int{{0, 0}, {0, 0}}
	unique_positions_counter := 1

	santa_index := 0
	for action in input {
		current_position := &current_positions[santa_index]

		switch (action) {
		case '<':
			current_position.x -= 1
		case '>':
			current_position.x += 1
		case '^':
			current_position.y -= 1
		case 'v':
			current_position.y += 1
		}

		is_duplicate := insert_into_tree(tree, current_position^)
		if !is_duplicate {
			unique_positions_counter += 1
		}

		santa_index = (santa_index + 1) % 2
	}

	return unique_positions_counter
}

Tree_Node :: struct {
	left, right: ^Tree_Node,
	value:       [2]int,
}

is_smaller :: proc(value, compare_to: [2]int) -> bool {
	if value.x == compare_to.x {
		return value.y < compare_to.y
	} else {
		return value.x < compare_to.x
	}
}

is_equal :: proc(value, compare_to: [2]int) -> bool {
	return value.x == compare_to.x && value.y == compare_to.y
}

insert_into_tree :: proc(root: ^Tree_Node, value: [2]int) -> (is_duplicate: bool) {
	if is_equal(value, root.value) {
		return true
	}

	insert_node := &root.left if is_smaller(value, root.value) else &root.right

	if insert_node^ == nil {
		insert_node^ = new(Tree_Node)
		insert_node^.value = value
		return false
	} else {
		return insert_into_tree(insert_node^, value)
	}
}

free_tree :: proc(root: ^Tree_Node) {
	if root.left != nil {
		free_tree(root.left)
	}

	if root.right != nil {
		free_tree(root.right)
	}

	free(root)
}

main :: proc() {
	data, err := os.read_entire_file_or_err("input/day03.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day03.txt")

	input := strings.trim_right_space(string(data))

	start := time.tick_now()
	part1_result := solve_day03_part1(input)
	duration := time.tick_since(start)

	fmt.printfln(
		"Part 1 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part1_result,
	)

	start = time.tick_now()
	part2_result := solve_day03_part2(input)
	duration = time.tick_since(start)

	fmt.printfln(
		"Part 2 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part2_result,
	)
}

@(test)
test_day03_part1 :: proc(state: ^testing.T) {
	testing.expect_value(state, solve_day03_part1(">"), 2)
	testing.expect_value(state, solve_day03_part1("^>v<"), 4)
	testing.expect_value(state, solve_day03_part1("^v^v^v^v^v"), 2)
}

@(test)
test_day03_part2 :: proc(state: ^testing.T) {
	testing.expect_value(state, solve_day03_part2("^v"), 3)
	testing.expect_value(state, solve_day03_part2("^>v<"), 3)
	testing.expect_value(state, solve_day03_part2("^v^v^v^v^v"), 11)
}

