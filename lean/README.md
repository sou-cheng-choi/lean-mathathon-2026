# lean: the Lean files of the talk

Install Lean first (see "Install" in `../README.md`). Each project folder has its own README with the
same steps in more detail, and an optional `Makefile` whose targets run those steps (see "With make" below).

| Folder or file | What it is | Slides |
| --- | --- | --- |
| `01_helloworld/` | Hello World, as `lake new helloworld` wrote it (no Mathlib) | Create a Project, Hello, World |
| `02_oddsum/` | A small core-Lean proof (the sum of the first n odd numbers) with its Comparator run, no Mathlib, kept as a quick test | None |
| `03_my_proofs/` | A first proof and three exercises, with their solutions, with Mathlib | A First Proof, Exercise 1 to Exercise 3, Exercise Solutions (backup) |
| `04_example1/` | Example 1 and Example 2 in Lean, with Mathlib, and its Comparator files | Create the Example 1 Project to Comparator on Example 1 |
| `bad.lean` | `theorem unproved_false_claim` with `sorry`, and `#print axioms` (core Lean, no project) | The Three Axioms and `sorry` (backup) |
| `lift_deps.lean` | Lists the project declarations used by `csminares_lift`; needs the paper's Lean project | The Lift in Lean: The Theorem |
| `docker/` | A Linux image and `run.sh`, which run Comparator on a Mac (`make compare` calls them) | Comparator on Example 1 |

Exercises 1–3 share the `03_my_proofs/` project: edit the three descriptively named theorems in
[`MyProofs/Exercises.lean`](03_my_proofs/MyProofs/Exercises.lean), then compare with
[`MyProofs/Solutions.lean`](03_my_proofs/MyProofs/Solutions.lean). One project shares the Lean version,
Mathlib dependency, and build settings; separate exercise folders are optional.

The numbers sort the projects by difficulty: the larger the number, the harder the project. They are only in the folder
names, and the Lake projects inside are still called `helloworld`, `oddsum`, `my_proofs`, and `example1`. Line 1 of every
`.lean` file says how to run it (`-- Run: ...`), from its project folder (`bad.lean` runs from this folder; `lift_deps.lean` runs from the paper's Lean project).

## In VS Code, or in a browser

Install the Lean 4 extension (`code --install-extension leanprover.lean4`, see `../README.md`), then open a
project folder, such as `01_helloworld/` or `03_my_proofs/`, in VS Code. There is no Run button: Lean checks each file as you type,
and the *Infoview* (Cmd+Shift+Enter) shows goals and `#eval` output. `bad.lean` needs no project. Without
installing anything, Lean 4 Web (<https://live.lean-lang.org>) checks small files, with Mathlib, in a browser.

## With make

Each project folder has an optional `Makefile`, a shortcut for the `lake` commands. In a project folder, `make` lists its targets, and `make TARGET` runs one.
Make prints each command before it runs it, so you see the `lake` commands of the step-by-step section below.

| Target | What it does | Projects |
| --- | --- | --- |
| `cache` | `lake exe cache get`: download prebuilt Mathlib, once (about 7 GB) | `03_my_proofs/`, `04_example1/` |
| `build` | `lake build`: compile the project and check every proof | All four |
| `run` | `lake exe helloworld`: run the program | `01_helloworld/` |
| `check` | `lake env lean FILE`: check one file and print its axioms | `03_my_proofs/` (`Exercises.lean`), `04_example1/` (`Lift.lean`), `02_oddsum/` (`Axioms.lean`) |
| `compare` | Comparator: does the project prove the statements of its `Challenge.lean`? | `02_oddsum/`, `03_my_proofs/`, `04_example1/` |
| `compare-exercises` | Verify the learner's `Exercises.lean`; reject unfinished proofs | `03_my_proofs/` |
| `clean` | `lake clean`: delete the build output and keep Mathlib | All four |
| `distclean` | `rm -rf .lake`: delete Mathlib too (about 7 GB) | `03_my_proofs/`, `04_example1/` |

Comparator needs Linux. On Linux, `make compare` runs `lake comparator` directly, after `sudo apt install bubblewrap`.
On macOS it runs the same commands in a Linux container with Docker, through `docker/run.sh` (see `docker/README.md`).
Start Docker Desktop first (`open -a Docker`). The first call builds the Docker image: here 8 minutes without Mathlib (3.6 GB) and
12 minutes with it (10.9 GB), mostly downloads.

`make` is part of Linux and, on macOS, of Xcode's command-line tools (`xcode-select --install`). Without it, type the
`lake` commands.

## Step by step

Run each block from this folder. The `make` target of each `lake` command is in the table above.

1. Hello World (seconds, no internet needed once Lean is installed):

       cd 01_helloworld
       lake build              # Build completed successfully (8 jobs).
       lake exe helloworld     # Hello, world!
       cd ..

2. A false theorem with `sorry` (no project needed):

       lean bad.lean           # warning: declaration uses `sorry`, then the two axiom lists

3. A core-Lean proof, with its own Comparator run (seconds, no Mathlib):

       cd 02_oddsum
       lake build                      # Build completed successfully (4 jobs).
       lake env lean Axioms.lean       # 'sum_of_odds_equals_square' depends on axioms: [propext, Quot.sound]
       cd ..

4. A first proof and the exercises (needs internet and about 7 GB for Mathlib, once per project):

       cd 03_my_proofs
       lake exe cache get              # prebuilt Mathlib v4.35.0
       lake build                      # Build completed successfully (9051 jobs), with the first proof and the solutions
       lake env lean MyProofs/Exercises.lean    # the handout as it is: 3 warnings, declaration uses `sorry`
       cd ..

   Do the exercises in VS Code, in `MyProofs/Exercises.lean`, and compare with `MyProofs/Solutions.lean`.
   When finished, run `make compare-exercises` in `03_my_proofs/` to verify your proofs, including their statements and axioms.

5. Example 1 and Example 2 (needs internet and about 7 GB for Mathlib):

       cd 04_example1
       lake exe cache get              # prebuilt Mathlib v4.35.0
       lake build                      # Build completed successfully (9050 jobs).
       lake env lean Example1/Lift.lean    # Example 2: 'lift_gives_minimum_norm' depends on axioms: [propext, Classical.choice, Quot.sound]
       cd ..

6. Comparator (Linux, or Docker on macOS): run `make compare` in each proof project:
   `02_oddsum/` (one theorem), `03_my_proofs/` (four), and `04_example1/` (ten). All configurations
   fix the definitions and use `--paranoid`. Hello World is an executable, with no theorem to compare.

The projects pin Lean 4.35.0 (Mathlib v4.35.0 for `03_my_proofs/` and `04_example1/`).
Theorem and helper names describe their meaning; conventional mathematical symbols such as `A`, `b`,
`n`, and `z` remain short. Library names and the executable entry point `main` retain their required spelling.

Validation on 2026-11-13: all four projects passed `make build`; Hello World printed `Hello, world!`.
Comparator accepted all 15 completed theorems (1 + 4 + 10) in all six kernel configurations.
Exercise handouts and `bad.lean` deliberately retain `sorry` and are not verified proofs.
The dependency-listing script still reports 15 declarations, including 6 definitions.

Beyond what `lake new` wrote, the Lean files here were generated with Anthropic Claude
(<https://www.anthropic.com/claude>) and are checked by Lean's kernel.

## Lift dependencies

`lift_deps.lean` needs the paper's `Csminares` library, so it is conditionally reproducible.
From the parent folder containing both repositories:

```sh
cd csminares-reproduce/lean
lake env lean ../../talk_caltech_mathathon/code/lean/lift_deps.lean
```

Expected with the pinned Lean 4.35.0 project: 15 declarations, including 6 definitions.
