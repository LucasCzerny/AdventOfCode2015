package aoc

solve_part2 :: proc(input: string) -> int {
	current_floor := 0

	for action, position in input {
		if action == '(' {
			current_floor += 1
		} else if action == ')' {
			current_floor -= 1
		}

		if current_floor == -1 {
			return position + 1
		}
	}

	panic("Failed to find the position where he enters the basement")
}

