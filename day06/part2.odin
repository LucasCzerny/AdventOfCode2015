package aoc

solve_part2 :: proc(input: []string) -> u32 {
	area := make([]u32, 1000 * 1000)
	defer delete(area)

	for line in input {
		type, top_left, bottom_right := parse_line(line)
		free_all(context.temp_allocator)

		switch type {
		case .turn_on:
			for y in top_left.y ..= bottom_right.y {
				for x in top_left.x ..= bottom_right.x {
					area[y * 1000 + x] += 1
				}
			}
		case .turn_off:
			for y in top_left.y ..= bottom_right.y {
				for x in top_left.x ..= bottom_right.x {
					if area[y * 1000 + x] == 0 {continue}
					area[y * 1000 + x] -= 1
				}
			}
		case .toggle:
			for y in top_left.y ..= bottom_right.y {
				for x in top_left.x ..= bottom_right.x {
					area[y * 1000 + x] += 2
				}
			}
		}
	}

	sum: u32 = 0

	for y in 0 ..< 1000 {
		for x in 0 ..< 1000 {
			sum += area[y * 1000 + x]
		}
	}

	return sum
}

