package aoc

solve_part1 :: proc(input: string) -> int {
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

