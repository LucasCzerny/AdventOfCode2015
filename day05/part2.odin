package aoc

solve_part2 :: proc(input: string) -> bool {
	LENGTH :: 16
	double_letters: [LENGTH - 1][2]u8

	prev_char := input[0]
	prev_prev_char: u8

	has_repeating_double_letter := false
	space_between_double_letter := false

	for i in 1 ..< len(input) {
		char := input[i]

		if !has_repeating_double_letter {
			double_letters[i - 1] = {prev_char, char}
			// log.error(double_letters)
			for j in 0 ..< i - 2 {
				if double_letters[i - 1] == double_letters[j] {
					has_repeating_double_letter = true
				}
			}
		}

		if prev_prev_char == char {
			space_between_double_letter = true
		}

		if has_repeating_double_letter && space_between_double_letter {
			return true
		}

		prev_prev_char = prev_char
		prev_char = char
	}

	return false
}

