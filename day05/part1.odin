package aoc

solve_part1 :: proc(input: string) -> bool {
	vowel_count := 0
	prev_char: u8

	has_double_letter := false

	for i in 0 ..< len(input) {
		char := input[i]

		if char == 'a' || char == 'e' || char == 'i' || char == 'o' || char == 'u' {
			vowel_count += 1
		}

		if prev_char == char {
			has_double_letter = true
		}

		if prev_char == 'a' && char == 'b' ||
		   prev_char == 'c' && char == 'd' ||
		   prev_char == 'p' && char == 'q' ||
		   prev_char == 'x' && char == 'y' {
			return false
		}

		prev_char = char
	}

	return vowel_count >= 3 && has_double_letter
}

