# Karakter (Zig version)

## Building

To build the `karakter` binary, you need to install [Zig](https://ziglang.org/download/). Then run:

```bash
cd zig && zig build && mv zig-out/bin/karakter . && cd ..
```

If you don’t want to bother with remembering individual build commands, just run `bin/build zig` from the root folder.

Any of these methods create a binary executable in the `zig` directory. You can run the command with `zig/karakter`.

## Notes to self

About Zig string handling:
<https://www.huy.rocks/everyday/01-04-2022-zig-strings-in-5-minutes>
