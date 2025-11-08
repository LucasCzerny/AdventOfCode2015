import os
import argparse
import subprocess
import sys

parser = argparse.ArgumentParser(description="Build and test an AoC day")
parser.add_argument("day", help="The AoC day to run (e.g. 1, 05, 15)")
parser.add_argument("--debug", action="store_true", help="Do a debug build")
args = parser.parse_args()

bold = "\033[1m"
clear = "\033[0m"

day_str = args.day.zfill(2)
source_path = f"src/day{day_str}.odin"
binary_name = f"day{day_str}"

if not os.path.exists(source_path):
    print(f"{bold}Error:{clear} source file {source_path} not found.")
    sys.exit(1)

if not os.path.exists("build"):
    os.makedirs("build")

flags = [
    "-strict-style",
    "-vet",
    f"-out=build/{binary_name}"
]

if args.debug:
    flags.append("-debug")

test_command = ["odin", "test", source_path, "-file", "-define:ODIN_TEST_LOG_LEVEL=warning"] + flags
run_command = ["odin", "run", source_path, "-file"] + flags

def run_step(title, cmd):
    print(f"{bold}[{title}]{clear}")
    print(f"Command:{clear} {' '.join(cmd)}")
    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
        print(f"{bold}Failed with exit code {e.returncode}{clear}")
        sys.exit(e.returncode)

run_step("Testing", test_command)
run_step("Result", run_command)
