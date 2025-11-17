package aoc

import "core:crypto/legacy/md5"
import "core:fmt"

Thread_Data :: struct {
	input:      string,
	suffix:     u64,
	result_ptr: ^u64,
}

NR_THREADS :: 8

md5_hash :: proc(key: string, suffix: u64) -> [md5.DIGEST_SIZE]byte {
	full_str := fmt.tprintf("%s%d", key, suffix)
	defer free_all(context.temp_allocator)

	ctx: md5.Context
	md5.init(&ctx)
	md5.update(&ctx, transmute([]byte)full_str)

	hash: [md5.DIGEST_SIZE]byte
	md5.final(&ctx, hash[:])

	return hash
}

