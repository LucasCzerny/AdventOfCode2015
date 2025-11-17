package aoc

import "core:sync"
import "core:thread"
import "core:time"

solve_part2 :: proc(input: string) -> u64 {
	result: u64 = 0

	thread_data: [NR_THREADS]Thread_Data
	threads: [NR_THREADS]^thread.Thread

	for i in 0 ..< NR_THREADS {
		thread_data[i] = Thread_Data {
			input      = input,
			suffix     = u64(i),
			result_ptr = &result,
		}

		threads[i] = thread.create_and_start_with_data(
			&thread_data[i],
			brute_force_hash_part2,
			init_context = context,
		)
	}

	for result == 0 {
		time.sleep(1 * time.Millisecond)
	}

	for t in threads {
		thread.destroy(t)
	}

	return result
}

brute_force_hash_part2 :: proc(raw_data: rawptr) {
	data := (cast(^Thread_Data)raw_data)^

	for data.result_ptr^ == 0 {
		hash := md5_hash(data.input, data.suffix)

		if starts_with_six_zeros(hash[:]) {
			sync.atomic_store(data.result_ptr, data.suffix)
		}

		data.suffix += NR_THREADS
	}
}

starts_with_six_zeros :: proc(hash: []byte) -> bool {
	return hash[0] == 0 && hash[1] == 0 && hash[2] == 0x0
}

