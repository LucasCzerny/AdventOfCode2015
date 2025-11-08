
package aoc

import "core:fmt"
import "core:os"
import "core:strings"
import "core:testing"
import "core:time"

solve_dayxx_part1 :: proc(input: string) -> int {
	return 0
}

solve_dayxx_part2 :: proc(input: string) -> int {
	return 0
}

main :: proc() {
	data, err := os.read_entire_file_or_err("input/dayxx.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/dayxx.txt")

	input := strings.trim_right_space(string(data))
	lines := strings.split_lines(input)
	defer delete(lines)

	part1_result := 0

	start := time.tick_now()
	for line in lines {
		part1_result += solve_dayxx_part1(line)
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
test_dayxx_part1 :: proc(state: ^testing.T) {
	testing.expect_value(state, solve_dayxx_part2(""), 0)

}

@(test)
test_dayxx_part2 :: proc(state: ^testing.T) {
	testing.expect_value(state, solve_dayxx_part2(""), 0)
}

