import std/terminal
from os import commandLineParams, fileExists
from std/strutils import split, splitLines, strip

from karakter/parse_opts import parseCommandLineOption

proc handleWord(word: string) =
  echo word

proc handleLine(line: string) =
  var word: string
  for word in split(line):
    handleWord(word)

proc main() =
  let parsedList = parseCommandLineOption(commandLineParams())

  if isatty(stdin):
    echo "Command line argument, check if file"
    let args = parsedList.args
    if args.len == 1:
      if fileExists(args[0]):
        echo "Is a file, contents:"
        let file = open(args[0])
        defer:
          file.close()

        var line: string
        while file.readLine(line):
          handleLine(line)
      # Return here so we can continue for any number of args
      return

    var word: string
    for word in args:
      handleWord(word)

  else:
    echo "Piped file, contents:"
    let content: string = readAll(stdin).strip()
    var line: string
    for line in splitLines(content):
      handleLine(line)

when isMainModule: main()
