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

	data, err := os.read_entire_file_or_err("input/day06.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day06.txt")

	ensure(solve_part1({"turn on 0,0 through 999,999"}) == 1000000)
	ensure(solve_part1({"toggle 0,0 through 999,0"}) == 1000)
	ensure(solve_part1({"turn off 499,499 through 500,500"}) == 0)

	input := strings.trim_right_space(string(data))
	lines := strings.split_lines(input)
	defer delete(lines)

	start := time.tick_now()
	part1_result := solve_part1(lines)
	duration := time.tick_since(start)

	fmt.printfln(
		"Part 1 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part1_result,
	)

	ensure(solve_part2({"turn on 0,0 through 0,0"}) == 1)
	ensure(solve_part2({"toggle 0,0 through 999,999"}) == 2000000)

	start = time.tick_now()
	part2_result := solve_part2(lines)
	duration = time.tick_since(start);start = time.tick_now()

	fmt.printfln(
		"Part 2 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part2_result,
	)
}

