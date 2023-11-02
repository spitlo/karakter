# Karakter (Odin version, WIP)

## Building

To build the `karakter` binary, you need to install [Odin](https://odin-lang.org/). Then, from the root folder, run:

```bash
bin/build odin
```

This will create a binary executable in the `odin` directory. You can run the command with `odin/karakter`.

## Development

During development, you might want to rebuild sets on each compile. Run:

```bash
bin/generate_sets && bin/build odin && odin/karakter THISisMYtestSENTENCEAAAABBBcdefg
```

That will regenerate sets, build the executable and run it with som test gibberish.
