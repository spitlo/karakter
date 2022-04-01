# Karakter (Bash version)

## Supplying text

There are three ways to supply input text to this script:

  1) Add a file as argument
  2) Add word or words as arguments
  3) Pipe text to it

## Options

### ~~Obfuscation level~~ Character

You can change the level of obfuscation by supplying the arguments `--lo`, `--md`, or `--hi`. This will affect the amount of characters changed.

### Style

If you’re not happy with the default style, you can supply arguments `--cp`, `--ft`, `--lm` or `--mt`, for a more `¢џБ≡┎pμ∩κ`, `ƒάїгψłάľє`, `LŌŪĐMŌŪṪH` or `₥0₦€¥₸₳£₭` look, respectively.

## Usage examples

Highly obfuscate text from a file on your filesystem:

```bash
bash/karakter test.txt --hi
```

Generate a mildly elvish version of your name for an email signature:

```bash
bash/karakter --md --ft John Doe
```

Turn A Tale of Two Cities into a cyberpunk novel and read it in your terminal:

```bash
curl https://www.gutenberg.org/files/98/98-0.txt | sed 's/one thousand seven/two thousand seven/g' | tr a-z A-Z | bash/karakter --md --cp | less
```
