# 02_oddsum: a small Lean proof checked by Comparator

The first demo of the talk, replaced on 2026-11-12 by Example 1 in `../04_example1/`. Kept as a quick test that
needs no Mathlib (it builds in seconds). Run every command below from this folder. No other files are needed,
except `../docker/` for Comparator on macOS. `Oddsum/Basic.lean` proves that the sum of the first n odd numbers is n squared, `Challenge.lean` states
the same theorem with `sorry`, and `oddsum.json` tells Comparator which theorem to compare. Its empty `definition_names` fixes the recursive sum definition.
Core Lean only, no Mathlib. Line 1 of every `.lean` file says how to run it (`-- Run: ...`). Created with `lake new oddsum lib` in Lean 4.35.0, and its files written with Anthropic
Claude (<https://www.anthropic.com/claude>).

## Step by step

1. Install Lean (see "Install" in `../../README.md`).
2. Compile the proof and list its axioms, from this folder (seconds, no Mathlib):

       lake build                     # Build completed successfully (4 jobs).
       lake env lean Axioms.lean      # 'sum_of_odds_equals_square' depends on axioms: [propext, Quot.sound]

3. Check the statement with Comparator (Linux, or Docker on macOS): `make compare`, as below. It ends with
   `Your solution is okay!`.
4. Or use the `Makefile`: `make` lists the targets. `make build`, `make check`, and `make compare` run the commands
   above, and `make clean` deletes the build output. Make prints each command before it runs it.

The same commands, as the earlier slides showed them:

    lake build                                   # Build completed successfully (4 jobs).
    lake env lean Axioms.lean                    # 'sum_of_odds_equals_square' depends on axioms: [propext, Quot.sound]

`make compare` runs these two commands:

    lake build Oddsum Challenge
    lake comparator --paranoid --config oddsum.json

Comparator's sandbox needs Linux (`bubblewrap`). On Linux, `make compare` runs them directly, after
`sudo apt install bubblewrap`. On macOS it runs them in a Linux container with Docker, through `../docker/run.sh`
(see `../docker/README.md`). Start Docker Desktop first (`open -a Docker`). The first call builds the Docker image
`lean-cmp`, with Lean 4.35.0 and bubblewrap but no Mathlib (3.6 GB, 8 minutes here, once, mostly the
download of Lean). It ends with `Your solution is okay!` after all six kernels accept. If `sum_of_odds_equals_square` instead states
`sumOfOddNumbers n = n ^ 2` (true, and provable from the same lemma), Comparator stops with
`error: Challenge and solution theorem statement do not match: 'sum_of_odds_equals_square'`.
Checked 2026-11-13 with `make compare`, in Docker on macOS. The rejection was checked on 2026-11-12.

## With conda instead of elan

conda-forge has a `lean4` package, but no elan. Tested 2026-11-12 in a fresh environment, with this folder:

    conda create -n lean -c conda-forge --override-channels lean4
    conda activate lean
    lake --version                 # Lake version 5.0.0-src (Lean version 4.33.0)
    lake build                     # Build completed successfully (4 jobs).
    lake env lean Axioms.lean      # 'sum_of_odds_equals_square' depends on axioms: [propext, Quot.sound]

Limits. conda-forge's newest Lean is 4.33.0, while this folder, the talk, and the paper pin 4.35.0 through elan.
Lake 4.33 has no `lake comparator`, so Comparator still runs in Docker. The environment takes about 2.8 GB, because
the package brings its own clang and LLVM. A Mathlib project needs the exact Lean version that its Mathlib release
pins, which is what elan manages, so the talk keeps elan.
