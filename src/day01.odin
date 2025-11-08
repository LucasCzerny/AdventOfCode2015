package aoc

import "core:fmt"
import "core:os"
import "core:strings"
import "core:testing"
import "core:time"

solve_day01_part1 :: proc(input: string) -> int {
	current_floor := 0

	for action in input {
		if action == '(' {
			current_floor += 1
		} else if action == ')' {
			current_floor -= 1
		}
	}

	return current_floor
}

solve_day01_part2 :: proc(input: string) -> int {
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

main :: proc() {
	data, err := os.read_entire_file_or_err("input/day01.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day01.txt")

	input := strings.trim_right_space(string(data))

	start := time.tick_now()
	part1_result := solve_day01_part1(input)
	duration := time.tick_since(start)

	fmt.printfln(
		"Part 1 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part1_result,
	)

	start = time.tick_now()
	part2_result := solve_day01_part2(input)
	duration = time.tick_since(start)

	fmt.printfln(
		"Part 2 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part2_result,
	)
}

@(test)
test_day01_part1 :: proc(state: ^testing.T) {
	testing.expect_value(state, solve_day01_part1("(())"), 0)
	testing.expect_value(state, solve_day01_part1("()()"), 0)
	testing.expect_value(state, solve_day01_part1("((("), 3)
	testing.expect_value(state, solve_day01_part1("(()(()("), 3)
	testing.expect_value(state, solve_day01_part1("))((((("), 3)
	testing.expect_value(state, solve_day01_part1("())"), -1)
	testing.expect_value(state, solve_day01_part1("))("), -1)
	testing.expect_value(state, solve_day01_part1(")))"), -3)
	testing.expect_value(state, solve_day01_part1(")())())"), -3)
}

@(test)
test_day01_part2 :: proc(state: ^testing.T) {
	testing.expect_value(state, solve_day01_part2(")"), 1)
	testing.expect_value(state, solve_day01_part2("()())"), 5)
}

