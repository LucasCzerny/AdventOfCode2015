package aoc

solve_part1 :: proc(input: string) -> int {
	sides := sides_from_input(input)

	smallest_area := max(int)
	total_area := 0

	for i in 0 ..< 3 {
		area := sides[i] * sides[(i + 1) % 3]
		total_area += 2 * area

		if area < smallest_area {
			smallest_area = area
		}
	}

	return total_area + smallest_area
}

