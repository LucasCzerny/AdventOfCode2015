package aoc

solve_part1 :: proc(input: string) -> int {
	current_floor := 0

	for action in input {
		if action == '(' {
			current_floor += 1
		} else if action == ')' {
			current_floor -= 1
		}
	}

	return current_floor
}

