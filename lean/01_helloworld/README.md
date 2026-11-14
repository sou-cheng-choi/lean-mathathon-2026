# 01_helloworld: the Hello World of the talk

The project behind the talk slides "Create a Project" and "Hello, World". It is what `lake new helloworld`
wrote in Lean 4.35.0 (default template `std`, a library plus a program), unchanged. No Mathlib.

## Who made each file

No files are needed before `lake new`. It wrote every file here but this README, the Makefile, and the `-- Run:` comment on line 1 of each `.lean` file:

| File | Made by |
| --- | --- |
| `lakefile.toml` | `lake new`: name, library `Helloworld`, program `helloworld` |
| `lean-toolchain` | `lake new`: the Lean version, `leanprover/lean4:v4.35.0` |
| `Main.lean` | `lake new`: the program, which prints `Hello, world!` |
| `Helloworld.lean` | `lake new`: the library root, `import Helloworld.Basic` |
| `Helloworld/Basic.lean` | `lake new`: `def hello := "world"` |
| `.gitignore` | `lake new`: `/.lake` |
| `README.md` | By hand, replacing the one-line README of `lake new` |
| `Makefile` | Written with Claude: the targets `build`, `run`, and `clean` run the commands below |

`lake new` also made a git repository (`.git/`) and a GitHub workflow (`.github/`), not kept here.
`lake build` writes `lake-manifest.json` and `.lake/`.

## Step by step

1. Install Lean (see "Install" in `../../README.md`).
2. Compile, from this folder (no internet needed once Lean 4.35.0 is installed):

       lake build              # Build completed successfully (8 jobs).

3. Run the program:

       lake exe helloworld     # Hello, world!

4. Or use the `Makefile`, in this folder: `make` lists the targets. `make build` runs `lake build`, `make run` runs
   `lake build` and then `lake exe helloworld`, and `make clean` deletes the build output (`lake clean`). Make prints
   each command before it runs it.
5. Comparator: not needed here. It compares theorem statements, and this project proves no theorem.
   `../04_example1/README.md` runs it on Example 1.

Without a program, `#eval` prints the same text while a file builds. Add `#eval s!"Hello, {hello}!"` to
`Helloworld/Basic.lean`, and `lake build` prints `info: Helloworld/Basic.lean:2:0: "Hello, world!"`.
Checked 2026-11-12.
