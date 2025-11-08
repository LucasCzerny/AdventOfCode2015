package aoc

import "core:fmt"
import "core:os"
import "core:strings"
import "core:testing"
import "core:time"

solve_dayxy_part1 :: proc(input: string) -> int {
	return 0
}

solve_dayxy_part2 :: proc(input: string) -> int {
	return 0
}

main :: proc() {
	data, err := os.read_entire_file_or_err("input/dayxy.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/dayxy.txt")

	input := strings.trim_right_space(string(data))

	start := time.tick_now()
	part1_result := solve_dayxy_part1(input)
	duration := time.tick_since(start)

	fmt.printfln(
		"Part 1 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part1_result,
	)

	start = time.tick_now()
	part2_result := solve_dayxy_part2(input)
	duration = time.tick_since(start)

	fmt.printfln(
		"Part 2 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part2_result,
	)
}

@(test)
test_dayxy_part1 :: proc(state: ^testing.T) {
	testing.expect_value(state, solve_dayxy_part1(""), 0)
}

@(test)
test_dayxy_part2 :: proc(state: ^testing.T) {
	testing.expect_value(state, solve_dayxy_part2(""), 0)
}

