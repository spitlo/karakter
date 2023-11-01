# Karakter (Vale version, WIP)

## Building

To build the `karakter` binary, you need to install [Vale](https://vale.dev). Then, from the root folder, run:

```bash
bin/build vale
```

This will create a binary executable in the `vale` directory. You can run the command with `vale/karakter`.

## Development

During development, you might want to rebuild sets on each compile. Run:

```bash
bin/generate_sets && bin/build vale && vale/karakter THISisMYtestSENTENCEAAAABBBcdefg
```

That will regenerate sets, build the executable and run it with som test gibberish.
