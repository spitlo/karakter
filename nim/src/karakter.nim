import os
from karakter/parse_opts import parseCommandLineOption

proc main() =
  let parsedList = parseCommandLineOption(commandLineParams())

  echo(parsedList)

when isMainModule: main()
