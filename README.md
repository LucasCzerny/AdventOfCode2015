
# Advent of Code 2024 in Odin

My happiness levels for each solution from 1-5: 🥲, 😬, 😌, 😃, 🤩

|                                               | Part 1                                        | Part 2                                        | Notes                                                                                                                     |
|:----------------------------------------------|:----------------------------------------------|:----------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| [Day 01](https://adventofcode.com/2015/day/1) | [part1.odin - 0.130ms](day01/part1.odin) - 🤩 | [part2.odin - 0.044ms](day01/part2.odin) - 🤩 | |
<!-- | [Day xx](https://adventofcode.com/2015/day/1) | [part1.odin - 0.253929ms](dayxx/part1.odin) - 🤩 | [part2.odin - 0.253929ms](dayxx/part2.odin) - 🤩 | | -->

## How to run

*NOTE:* You're not allowed to upload your puzzle input to GitHub.
If you clone this repo, create a folder called input/ at the root and place your dayxx.txt files inside.

To run a solution:

```bash
odin run dayxx
```

Do **not** `cd dayxx` first.

To enable the tracking allocator, which detects memory leaks and bad frees:

```bash
odin run dayxx
```

Note on the runtimes

To measure the speed of each solution, I simply do:

```odin
start := time.tick_now()
partx_result := solve_partx(input)
duration := time.tick_since(start)
```

This is good enough for my purposes and I didn't want to do any sophisticated benchmarking.
