package main

import "core:os"
import "core:fmt"
import "core:strings"
// import "core:unicode/utf8"

import rl "vendor:raylib"

import "shared:sets"

// https://github.com/odin-lang/examples/blob/master/by_example/dir_info/main.odin
// https://github.com/odin-lang/examples/blob/master/by_example/os_args/main.odin
// https://github.com/odin-lang/examples/blob/master/by_example/strings/basic_string_example.odin

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
  args := os.args[1:]

  for line in args {
    words := strings.split(line, " ")
    for word in words {
      chars := strings.split(word, "")
      for char in chars {
        fmt.print(handle_char(char))
      }
    }
  }

  fmt.println()
}
