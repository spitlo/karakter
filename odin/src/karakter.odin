package main

import "core:os"
import "core:fmt"
import "core:strings"
// import "core:unicode/utf8"

import rl "vendor:raylib"

import "shared:sets"
import getopts "shared:getopts"

// https://github.com/odin-lang/examples/blob/master/by_example/dir_info/main.odin
// https://github.com/odin-lang/examples/blob/master/by_example/os_args/main.odin
// https://github.com/odin-lang/examples/blob/master/by_example/strings/basic_string_example.odin
// https://www.youtube.com/watch?v=0GGJBm0r3nA

handle_alpha :: proc(char: string) -> string {
  substitutes := sets.cyberpunk[char]
  subs_array := strings.split(substitutes, "")
  subs_len := i32(len(subs_array))

  index := -1
  if subs_len > 1 {
    index = int(rl.GetRandomValue(0, subs_len - 2))
  } else if subs_len == 1 {
    index = 0
  }

  subs_char := char

  if index > -1 {
    subs_char = subs_array[index]
  }

  return subs_char
}

handle_char :: proc(char: string) -> string {
  switch char {
    case "A"..="Z", "a"..="z":
      return handle_alpha(char)
    case:
      return char
  }
}

main :: proc() {
  opts := getopts.init_opts()
  defer getopts.deinit_opts(&opts)

  getopts.add_arg(&opts, "o", getopts.optarg_opt.OPTIONAL_ARGUMENT, "obfuscation")
  getopts.add_arg(&opts, "s", getopts.optarg_opt.OPTIONAL_ARGUMENT, "style")

  getopts.getopt_long(os.args, &opts)

  for opt in opts.opts {
    if !opt.set do continue
    switch opt.name {
      case "o":
        fmt.println(opt)
      case "s":
        fmt.println(opt)
      case:
        fmt.println("Failure")
    }
  }

  input := ""

  if len(opts.input) > 0 {
    input = opts.input
  } else {
    // Exit for now, check for pipe or file later
    os.exit(1)
  }

  lines := strings.split(input, "\n")

  for line in lines {
    chars := strings.split(line, "")
    for char in chars {
      fmt.print(handle_char(char))
    }
  }

  fmt.println()
}
