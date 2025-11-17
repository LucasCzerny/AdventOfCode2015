package aoc

solve_part2 :: proc(input: string) -> int {
	sides := sides_from_input(input)

	half_loop := [3]int{sides[0] + sides[1], sides[1] + sides[2], sides[2] + sides[0]}
	shortest_loop := 2 * min(half_loop[0], half_loop[1], half_loop[2])

	volume := sides[0] * sides[1] * sides[2]

	return shortest_loop + volume
}

