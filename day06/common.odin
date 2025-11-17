package aoc

import "core:strconv"
import "core:strings"

Type :: enum {
	turn_on,
	turn_off,
	toggle,
}

parse_line :: proc(line: string) -> (Type, [2]int, [2]int) {
	action: Type
	coordinates_str: string

	if line[:4] == "turn" {
		if line[5:7] == "on" {
			action = .turn_on
			coordinates_str = strings.trim_prefix(line, "turn on ")
		} else {
			action = .turn_off
			coordinates_str = strings.trim_prefix(line, "turn off ")
		}
	} else {
		action = .toggle
		coordinates_str = strings.trim_prefix(line, "toggle ")
	}

	both_coordinates := strings.split(coordinates_str, " through ", context.temp_allocator)

	top_left_str := both_coordinates[0]
	bottom_right_str := both_coordinates[1]

	both_top_left := strings.split(top_left_str, ",", context.temp_allocator)
	top_left := [2]int{strconv.atoi(both_top_left[0]), strconv.atoi(both_top_left[1])}

	both_bottom_right := strings.split(bottom_right_str, ",", context.temp_allocator)
	bottom_right := [2]int{strconv.atoi(both_bottom_right[0]), strconv.atoi(both_bottom_right[1])}

	return action, top_left, bottom_right
}

