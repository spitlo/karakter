package main

import "core:os"
import "core:fmt"
import "core:strings"

import getopts "shared:getopts"

show_help :: proc(opts: getopts.Options) {
  fmt.println("Arguments")
  for &opt in opts.opts {
    fmt.printf("-%s, --%s\n\t%s\n", opt.name, opt.alt_name, opt.help_text)
  }
}
