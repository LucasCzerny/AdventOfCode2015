package aoc

import "core:fmt"
import "core:mem"
import "core:os"
import "core:strings"
import "core:time"

main :: proc() {
	when ODIN_DEBUG {
		tracking_allocator: mem.Tracking_Allocator
		mem.tracking_allocator_init(&tracking_allocator, context.allocator)
		context.allocator = mem.tracking_allocator(&tracking_allocator)

		defer {
			for _, entry in tracking_allocator.allocation_map {
				context.logger = {}
				fmt.println("%v leaked %d bytes", entry.location, entry.size)
			}

			for entry in tracking_allocator.bad_free_array {
				context.logger = {}
				fmt.println("%v bad free on %v", entry.location, entry.memory)
			}

			mem.tracking_allocator_destroy(&tracking_allocator)
		}
	}

	data, err := os.read_entire_file_or_err("input/day05.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day05.txt")

	ensure(solve_part1("ugknbfddgicrmopn") == true)
	ensure(solve_part1("aaa") == true)
	ensure(solve_part1("jchzalrnumimnmhp") == false)
	ensure(solve_part1("haegwjzuvuyypxyu") == false)
	ensure(solve_part1("dvszwmarrgswjxmb") == false)

	input := strings.trim_right_space(string(data))
	lines := strings.split_lines(input)
	defer delete(lines)

	part1_result := 0

	start := time.tick_now()
	for line in lines {
		part1_result += cast(int)solve_part1(line)
	}
	duration := time.tick_since(start)

	fmt.printfln(
		"Part 1 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part1_result,
	)

	ensure(solve_part2("qjhvhtzxzqqjkmpb") == true)
	ensure(solve_part2("xxyxx") == true)
	ensure(solve_part2("uurcxstgmygtbstg") == false)
	ensure(solve_part2("ieodomkazucvgmuy") == false)

	part2_result := 0

	start = time.tick_now()
	for line in lines {
		part2_result += cast(int)solve_part2(line)
	}
	duration = time.tick_since(start)

	fmt.printfln(
		"Part 2 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part2_result,
	)
}

