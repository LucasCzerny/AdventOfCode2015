package aoc

import "core:strconv"
import "core:strings"

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

