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

	data, err := os.read_entire_file_or_err("input/day04.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day04.txt")

	ensure(solve_part1("abcdef", 609043) == 609043)

	input := strings.trim_right_space(string(data))

	start := time.tick_now()
	part1_result := solve_part1(input)
	duration := time.tick_since(start)

	fmt.printfln(
		"Part 1 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part1_result,
	)

	ensure(solve_part1("pqrstuv", 1048970) == 1048970)

	start = time.tick_now()
	part2_result := solve_part2(input)
	duration = time.tick_since(start)

	fmt.printfln(
		"Part 2 result (in %f ms): %d",
		time.duration_milliseconds(duration),
		part2_result,
	)
}

