# 04_example1: Example 1 of the talk in Lean, checked by Comparator

The demo behind the talk slides "Install Lean", "Create the Example 1 Project", "Example 1 in Lean", and "Comparator on Example 1".
`Example1/Basic.lean` defines the matrix `A`, the right-hand side `b`, and the claimed minimum-norm
least-squares solution `solution` (x† on the slides). It proves that `A` is complex symmetric (`matrix_is_symmetric`),
that `solution` solves the normal equations (`solution_is_least_squares`), and that `solution` lies in the range of `Aᴴ` (`solution_is_in_adjoint_range`).
The last two make `solution` the minimum-norm least-squares solution. `Challenge.lean` states all ten Example 1/2 theorems with `sorry`. `all_examples.json` selects all ten;
`example1.json` selects the two solution properties shown in the talk. Each configuration leaves `definition_names` empty, so the challenge fixes `A`, `b`, and `solution`. A nonempty `definition_names` would instead allow those definition bodies to vary.
`Example1/Lift.lean` proves Example 2 of the talk on the same data: the iterate `iterate` is stationary
(`iterate_is_stationary`), is not `solution` (`iterate_is_not_minimum_norm`), and the lift `iterate - liftCoefficient • star residualVector` equals `solution` (`lift_gives_minimum_norm`).
Lean 4.35.0 with Mathlib v4.35.0.

## Step by step

1. Install Lean (see "Install" in `../../README.md`).
2. Compile the proofs, from this folder (needs internet and about 7 GB):

       lake exe cache get                  # prebuilt Mathlib v4.35.0
       lake build                          # Build completed successfully (9050 jobs).
       lake env lean Example1/Lift.lean    # 'lift_gives_minimum_norm' depends on axioms: [propext, Classical.choice, Quot.sound]

   `lake build` compiles both `Example1/Basic.lean` and `Example1/Lift.lean`, through `Example1.lean`,
   and prints the axiom dependencies of the least-squares and lift proofs.
3. Check the statements with Comparator (Linux, or Docker on macOS): `make compare`, see "Comparator" below.
   It ends with `Your solution is okay!`.
4. Or use the `Makefile`, in this folder: `make` lists the targets. `make cache`, `make build`, `make check`, and
   `make compare` run the commands above (`make check` is `lake env lean Example1/Lift.lean`), `make clean` deletes the
   build output and keeps Mathlib, and `make distclean` deletes Mathlib too (about 7 GB). Make prints each command
   before it runs it.

Created with `lake new example1 math-lax`, then a `Challenge` library was added to `lakefile.toml`.
The `math` template also turns on Mathlib's style linters, which ask every file for a copyright header.

## Who made each file

No files are needed before `lake new`. It wrote most of this folder:

| File | Made by |
| --- | --- |
| `lakefile.toml` | `lake new` (name, library `Example1`, Mathlib `v4.35.0`), plus three lines added by hand for the `Challenge` library |
| `lean-toolchain` | `lake new`: the Lean version, `leanprover/lean4:v4.35.0`, that elan runs |
| `lake-manifest.json` | `lake new`, while it fetched Mathlib: the exact commits of Mathlib and its dependencies |
| `.gitignore` | `lake new`: `/.lake` |
| `Example1.lean` | `lake new`: the library root, `import Example1.Basic`; `import Example1.Lift` and the `-- Run:` line were added |
| `Example1/Basic.lean` | `lake new` wrote `def hello := "world"`, then the contents were replaced with Example 1, written with Claude |
| `Example1/Lift.lean` | Written with Claude: Example 2 of the talk, included in `lake build` |
| `Challenge.lean`, `example1.json`, `all_examples.json` | Written with Claude, for Comparator only |
| `README.md` | Written with Claude, replacing the one-line README of `lake new` |
| `Makefile` | Written with Claude: the targets `cache`, `build`, `check`, `compare`, `clean`, and `distclean` run the commands below |

Line 1 of every `.lean` file says how to run it (`-- Run: ...`), from this folder.

`lake new` also made a git repository (`.git/`), a GitHub workflow (`.github/`), and `.lake/` with Mathlib (about 7 GB),
none of which are kept here. `lake exe cache get` and `lake build` recreate `.lake/`.

## Install Lean (macOS or Linux)

Run these from any folder. No other files are needed:

    curl -sSfO https://elan.lean-lang.org/elan-init.sh   # download the installer script
    sh elan-init.sh -y                                    # run it: installs elan, no questions

`elan` is Lean's version manager. It goes into `~/.elan`, and the installer adds `~/.elan/bin` to `PATH`
in `~/.profile` and `~/.zprofile`. With `-y` it asks nothing, and over an existing elan it replaces elan
and keeps the installed Lean versions. In a new terminal, the first `lake --version` downloads Lean 4.35.0
and prints `Lake version 5.0.0-src+eb6cafb (Lean version 4.35.0)`.

`lake new NAME math-lax` creates the folder `NAME/` inside the current folder, with Mathlib pinned to
`v4.35.0`, and downloads prebuilt Mathlib (about 7 GB per project). It stops with
`error: package already initialized` if `NAME/` already holds a project.

## Hello World first (talk slides 17 and 18)

Before Example 1, the slides check the setup with a second project, `../01_helloworld/`, made by
`lake new helloworld` (no Mathlib). Its README has the commands. Here, `lake new` wrote
`def hello := "world"` into `Example1/Basic.lean`, and the file was then replaced with Example 1.

## Reproduce the slide output

From this folder (it needs internet and about 7 GB):

    lake exe cache get        # Mathlib v4.35.0, pinned by lake-manifest.json, with prebuilt files
    lake build                # Build completed successfully (9050 jobs).

Each source that directly imports Mathlib prints a warning, that Mathlib is designed for Lean's new module system (harmless here),
and the result of `#print axioms solution_is_least_squares`:
`'solution_is_least_squares' depends on axioms: [propext, Classical.choice, Quot.sound]`.

## Comparator

`make compare` checks all ten theorems against `Challenge.lean`, keeping all six definitions fixed:

    lake build Example1 Challenge
    lake comparator --paranoid --config all_examples.json

Comparator's sandbox needs Linux (bubblewrap). On Linux, `make compare` runs them directly, after
`sudo apt install bubblewrap`. On macOS it runs them in a Linux container with Docker, through `../docker/run.sh`
(see `../docker/README.md`). Start Docker Desktop first (`open -a Docker`, which starts the Docker daemon, Docker's
background service), and wait until `docker info` answers. The first call builds the Docker image `lean-cmp-mathlib`,
with Lean 4.35.0, bubblewrap, and prebuilt Mathlib v4.35.0 (10.9 GB, 12 minutes here, once, mostly downloads). Each call
after that takes about 1 minute.

It ends with `Your solution is okay!` after all six kernels accept. If `solution_is_least_squares` instead
states the same normal equations rearranged, `Aᴴ *ᵥ (A *ᵥ solution) = Aᴴ *ᵥ b` (true, and proved by the same
tactics), Comparator stops with `error: Challenge and solution theorem statement do not match: 'solution_is_least_squares'`, and
`make` reports an error.
Checked 2026-11-13: `make build` and `make compare` passed; all ten theorems were accepted
by all six Comparator kernel configurations, with no definition holes.

For the shorter two-theorem demonstration in the slides, use `--config example1.json`.
The statement-mismatch rejection was checked on 2026-11-12 with the earlier names.
Claude here is Anthropic Claude, <https://www.anthropic.com/claude>.

## Uninstall

    elan self uninstall       # removes ~/.elan: elan and every Lean version
    rm -rf ~/.cache/mathlib   # the Mathlib download cache

Then delete the project folders. Each keeps its own Mathlib in `.lake/`, about 7 GB.
