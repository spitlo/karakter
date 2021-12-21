# Karakter (V version)

## Building

To build the `karakter` binary, you need to install [V](https://vlang.io). Then run:

```bash
v v/karakter.v
```

If you don’t want to bother with remembering individual build commands, just run `bin/build v` from the root folder.

Any of these methods create a binary executable in the `v` directory. You can run the command with `v/karakter`.

## Supplying text

There are three ways to supply input text to this script:

  1) Add a file as argument
  2) Add word or words as arguments
  3) Pipe text to it

## Options

### ~~Obfuscation level~~ Character

You can change the level of obfuscation by supplying the argument `--obfuscation`, or `-o` for short. Possible values are `lo`, `md`, or `hi`. This will affect the amount of characters changed.

### Style

If you’re not happy with the default style, you can supply argument `--style`, or `-s` for short. Possible values are `cp` for a more `¢џБ≡┎pμ∩κ` look, or `ft` for a more `ƒάїгψłάľє` one.

## Usage examples

Highly obfuscate text from a file on your filesystem:

```bash
v/karakter test.txt --obfuscation=hi
```

Generate a mildly elvish version of your name for an email signature:

```bash
v/karakter --obfuscation md --style ft John Doe
```

Turn A Tale of Two Cities into a cyberpunk novel and read it in your terminal:

```bash
curl https://www.gutenberg.org/files/98/98-0.txt | sed 's/one thousand seven/two thousand seven/g' | tr a-z A-Z | v/karakter -o md -s cp | less
```
