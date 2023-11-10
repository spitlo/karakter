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

Set :: map[string]string

obfuscation_amounts := map[string]int {
  "lo" = 10,
  "md" = 50,
  "hi" = 100,
}

obfuscation_styles := map[string]string {
  "cp" = "cyberpunk",
  "ft" = "fairytale",
  "lm" = "loudmouth",
  "mt" = "moneytalk",
  "ns" = "numbers",
  "st" = "standard",
}

obfuscation_amount: int
obfuscation_style: string

set_obfuscation_amount :: proc(opt: getopts.Option) {
  if opt.set {
    obf_amount, ok := opt.val.(string)
    if !ok {
      fmt.println("Could not parse obfuscation argument, exiting.")
      os.exit(1)
    }
    obfuscation_amount = obfuscation_amounts[obf_amount]

    if obfuscation_amounts[obf_amount] < 1 {
      fmt.println("Could not parse obfuscation argument, exiting.")
      os.exit(1)
    }
  }
}

set_obfuscation_style :: proc(opt: getopts.Option) {
  if opt.set {
    obf_style, ok := opt.val.(string)
    if !ok {
      fmt.println("Could not parse style argument, exiting.")
      os.exit(1)
    }
    obfuscation_style = obfuscation_styles[obf_style]

    if len(obfuscation_styles[obf_style]) == 0 {
      fmt.println("Could not parse style argument, exiting.")
      os.exit(1)
    }
  }
}

handle_alpha :: proc(char: string) -> string {
  // Don’t obfuscate this character if obfuscation amount fall below chance amount
  chance := int(rl.GetRandomValue(0, 100))
  if chance > obfuscation_amount {
    return char
  }

  // Perhaps do this once only in main?
  set: map[string]string = ---
  switch obfuscation_style {
    case "cyberpunk":
      set = sets.cyberpunk
    case "fairytale":
      set = sets.fairytale
    case "loudmouth":
      set = sets.loudmouth
    case "moneytalk":
      set = sets.moneytalk
    case "numbers":
      set = sets.numbers
    case:
      set = sets.standard
  }
  substitutes := set[char]
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
  // Set defaults
  obfuscation_amount = obfuscation_amounts["md"]
  obfuscation_style = obfuscation_styles["st"]

  // Now check arguments
  opts := getopts.init_opts()
  defer getopts.deinit_opts(&opts)

  getopts.add_arg(&opts, "o", getopts.optarg_opt.OPTIONAL_ARGUMENT, "obfuscation")
  getopts.add_arg(&opts, "s", getopts.optarg_opt.OPTIONAL_ARGUMENT, "style")

  getopts.getopt_long(os.args, &opts)

  fmt.printf("Obfuscation amount: %s \n", obfuscation_amount)
  fmt.printf("Obfuscation style: %s \n", obfuscation_style)


  for opt in opts.opts {
    if !opt.set do continue
    switch opt.name {
      case "o":
        set_obfuscation_amount(opt)
      case "s":
        set_obfuscation_style(opt)
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

  clear(&obfuscation_amounts)
  clear(&obfuscation_styles)

  fmt.println()
}
