# 03_my_proofs: the first proof and the three exercises of the talk

The Lean project behind the talk slides "A First Proof" and "Exercise 1" to "Exercise 3". It is what
`lake new my_proofs math-lax` wrote in Lean 4.35.0 (Mathlib `v4.35.0`), plus the proof and exercise files below. The exercises
are steps of the talk's proof, in order of difficulty: a first proof with `simp`, then the conjugate transpose
(`rw`), the 2 by 2 example (`ext`, `fin_cases`, `simp`), and step 3 of the proof (inner products).

## Who made each file

No files are needed before `lake new`. It wrote most of this folder:

| File | Made by |
| --- | --- |
| `lakefile.toml` | `lake new`: name `my_proofs`, library `MyProofs`, Mathlib `v4.35.0` |
| `lean-toolchain` | `lake new`: the Lean version, `leanprover/lean4:v4.35.0` |
| `lake-manifest.json` | `lake new`, while it fetched Mathlib: the exact commits of Mathlib and its dependencies |
| `.gitignore` | `lake new`: `/.lake` |
| `MyProofs/Basic.lean` | `lake new`: `def hello := "world"`, plus the `-- Run:` line |
| `MyProofs.lean` | `lake new` wrote `import MyProofs.Basic`, then two imports were added by hand, `First` and `Solutions` |
| `MyProofs/First.lean` | Written with Claude: the first proof, `conjugate_product_is_real` |
| `MyProofs/Exercises.lean` | Written with Claude: the handout, three theorems with `sorry` |
| `MyProofs/Solutions.lean` | Written with Claude: the same three theorems, proved |
| `Challenge.lean`, `my_proofs.json` | Statement-only specification and Comparator configuration for the first proof and three solutions |
| `my_exercises.json` | Comparator configuration for the learner's `MyProofs/Exercises.lean`, independent of the supplied solutions |
| `README.md` | Written with Claude, replacing the one-line README of `lake new` |
| `Makefile` | Written with Claude: the targets `cache`, `build`, `check`, `compare`, `compare-exercises`, `clean`, and `distclean` run the commands below |

Line 1 of every `.lean` file says how to run it (`-- Run: ...`), from this folder.

`lake new` also made a git repository (`.git/`), a GitHub workflow (`.github/`), and `.lake/` with Mathlib (about 7 GB),
none of which are kept here. `lake exe cache get` and `lake build` recreate `.lake/`. The template `math-lax` is used
because the template `math` turns on Mathlib's style linters, which warn about a missing copyright header and module
docstring on every file below.

## Step by step

1. Install Lean and VS Code with its Lean 4 extension (see `../../README.md`).
2. From this folder (needs internet and about 7 GB):

       lake exe cache get      # download prebuilt Mathlib v4.35.0, instead of compiling it
       lake build              # Build completed successfully (9051 jobs).

   `lake build` checks `First.lean` and `Solutions.lean` (through `MyProofs.lean`). It prints one harmless
   warning per file, that Mathlib is designed for Lean's new module system, and the axioms of `adjoint_of_symmetric_is_conjugate`, `lift_removes_second_component`, `coefficient_from_inner_product`:
   `depends on axioms: [propext, Classical.choice, Quot.sound]`.
3. Do the exercises in VS Code: open this folder, then `MyProofs/Exercises.lean`. Replace each `sorry` with a proof,
   using the hint in the comment above it, and watch the *Infoview* (Cmd+Shift+Enter). Done when there is no red
   underline and `#print axioms` lists only the three standard axioms. From a terminal:

       lake env lean MyProofs/Exercises.lean    # with the handout as it is: 3 warnings, declaration uses `sorry`

   `Exercises.lean` is not imported by `MyProofs.lean`, because `Solutions.lean` defines the same names.
4. Compare with `MyProofs/Solutions.lean`.
5. Or use the `Makefile`, in this folder: `make` lists the targets. `make cache`, `make build`, and `make check` run
   the three commands above (`make check` checks your `MyProofs/Exercises.lean`), `make clean` deletes the build output
   and keeps Mathlib, and `make distclean` deletes Mathlib too (about 7 GB). Make prints each command before it runs it.
6. After completing the handout, run `make compare-exercises`. It checks **your**
   `MyProofs/Exercises.lean` against the three fixed statements in `Challenge.lean`; the original
   handout fails because `sorryAx` is not permitted. Unlike `make check`, this target rejects
   unfinished proofs.
7. Run `make compare` to verify the first proof and all three supplied solutions against `Challenge.lean`.
   It runs `lake build MyProofs Challenge` and `lake comparator --paranoid --config my_proofs.json`.
   On macOS, start Docker Desktop first; the target uses `../docker/run.sh`. The unfinished handout
   is separate: its intentional `sorry` placeholders are not verified solutions.

Checked 2026-11-13: `make build` and `make compare` passed with Lean 4.35.0, Mathlib v4.35.0,
and all six Comparator kernel configurations. `make compare-exercises` was also checked: it
rejects the original handout's `sorryAx` and accepts the completed solutions in a temporary container.

Claude here is Anthropic Claude, <https://www.anthropic.com/claude>.
