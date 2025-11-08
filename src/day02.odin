package aoc

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

solve_day02_part1 :: proc(input: string) -> int {
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

solve_day02_part2 :: proc(input: string) -> int {
	sides := sides_from_input(input)

	half_loop := [3]int{sides[0] + sides[1], sides[1] + sides[2], sides[2] + sides[0]}
	shortest_loop := 2 * min(half_loop[0], half_loop[1], half_loop[2])

	volume := sides[0] * sides[1] * sides[2]

	return shortest_loop + volume
}

sides_from_input :: proc(input: string) -> [3]int {
	sides_str := strings.split(input, "x")
	defer delete(sides_str)
	assert(len(sides_str) == 3)

	sides: [3]int
	for i in 0 ..< 3 {
		sides[i] = strconv.atoi(sides_str[i])
	}

	return sides
}

main :: proc() {
	data, err := os.read_entire_file_or_err("input/day02.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day02.txt")

	input := strings.trim_right_space(string(data))
	lines := strings.split_lines(input)
	defer delete(lines)

	part1_result := 0

	start := time.tick_now()
	for line in lines {
		part1_result += solve_day02_part1(line)
	}
	duration := time.tick_since(start)

	fmt.printfln(
		"Part 1 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part1_result,
	)

	part2_result := 0

	start = time.tick_now()
	for line in lines {
		part2_result += solve_day02_part2(line)
	}
	duration = time.tick_since(start)

	fmt.printfln(
		"Part 2 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part2_result,
	)
}

@(test)
test_day02_part1 :: proc(state: ^testing.T) {
	testing.expect_value(state, solve_day02_part1("2x3x4"), 58)
	testing.expect_value(state, solve_day02_part1("1x1x10"), 43)
}

@(test)
test_day02_part2 :: proc(state: ^testing.T) {
	testing.expect_value(state, solve_day02_part2("2x3x4"), 34)
	testing.expect_value(state, solve_day02_part2("1x1x10"), 14)
}

