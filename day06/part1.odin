package aoc

solve_part1 :: proc(input: []string) -> int {
	area := make([]bool, 1000 * 1000)
	defer delete(area)

	for line in input {
		type, top_left, bottom_right := parse_line(line)
		free_all(context.temp_allocator)

		switch type {
		case .turn_on:
			for y in top_left.y ..= bottom_right.y {
				for x in top_left.x ..= bottom_right.x {
					area[y * 1000 + x] = true
				}
			}
		case .turn_off:
			for y in top_left.y ..= bottom_right.y {
				for x in top_left.x ..= bottom_right.x {
					area[y * 1000 + x] = false
				}
			}
		case .toggle:
			for y in top_left.y ..= bottom_right.y {
				for x in top_left.x ..= bottom_right.x {
					area[y * 1000 + x] = !area[y * 1000 + x]
				}
			}
		}
	}

	sum := 0

	for y in 0 ..< 1000 {
		for x in 0 ..< 1000 {
			sum += cast(int)area[y * 1000 + x]
		}
	}

	return sum
}

