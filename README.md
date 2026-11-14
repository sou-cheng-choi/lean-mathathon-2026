# Code for "A Proof Assistant for a Mathematical Algorithm"

Lean 4, MATLAB, and Julia files behind the talk "A Proof Assistant for a Mathematical Algorithm"
(Lean 4 for Minimum-Norm Solutions of Complex Symmetric Systems) by Sou-Cheng T. Choi (Illinois Tech) at the
Caltech Mathathon, November 13-15, 2026. The talk follows one claim about the solver CS-MinAres, the minimum-norm
lift, from a 2 by 2 example to a proof checked by Lean. The paper behind it, by S.-C. T. Choi, A. Montoison,
D. Orban, and M. A. Saunders, is a manuscript, and its full Lean formalization will be released with it.
This repository: <https://github.com/sou-cheng-choi/lean-mathathon-2026>.

## Contents

| Folder or file | What it is | Reproducibility |
| --- | --- | --- |
| `lean/` | The Lean files of the talk. Its README has the steps for all of them. The project folders are numbered by difficulty, and a larger number is harder | |
| `lean/01_helloworld/` | Hello World, as `lake new helloworld` wrote it (no Mathlib) | ER |
| `lean/02_oddsum/` | A small core-Lean demo, the sum of the first n odd numbers | ER |
| `lean/03_my_proofs/` | A first proof and three exercises, with their solutions, with Mathlib | CR: Mathlib, about 7 GB |
| `lean/04_example1/` | Example 1 in Lean with Mathlib, its Comparator files, and Example 2 in `Example1/Lift.lean` | CR: Mathlib, about 7 GB |
| `lean/bad.lean` | `theorem unproved_false_claim` with `sorry`, and `#print axioms` | ER |
| `lean/lift_deps.lean` | Lists the project declarations used by the lift theorem | CR: the paper's Lean project (`Csminares`) |
| `lean/docker/` | The Linux image and script that run Comparator on a Mac (`make compare` calls them) | CR: Docker |
| `matlab/` | Examples 1 and 2 in MATLAB | ER |
| `julia/` | Examples 1 and 2 in Julia, and `lift_demo.jl` for the numbers of Examples 2 to 4 | ER, and CR for `lift_demo.jl` |

ER (easily reproducible): one command after installing the required language. CR (conditionally reproducible): needs more, such as Mathlib
or a pinned Krylov.jl. Every folder has a README with step-by-step commands, and every Lean project has an optional `Makefile`
whose targets run them: `make` lists the targets.

## Install

Commands for macOS or Linux. Each tool is needed only for the files that use it.

    # Lean 4 (elan, Lean's version manager)
    curl -sSfO https://elan.lean-lang.org/elan-init.sh   # download the installer
    sh elan-init.sh -y                                    # install it, no questions
    lake --version                                        # new terminal: downloads Lean 4.35.0 on first use

    # make, for the Makefiles of the Lean projects (part of Linux, and on macOS of Xcode's command-line tools)
    make --version || xcode-select --install

    # VS Code and its Lean 4 extension, to edit Lean with live feedback and syntax colors
    code --install-extension leanprover.lean4

    # Julia, for julia/
    curl -fsSL https://install.julialang.org | sh

    # Docker, only for Comparator on macOS: Docker Desktop from https://www.docker.com/products/docker-desktop/
    open -a Docker      # starts Docker Desktop and its background service, the Docker daemon
    docker info         # answers once the daemon runs (otherwise: Cannot connect to the Docker daemon)

MATLAB, for `matlab/`, needs a license: <https://www.mathworks.com/products/matlab.html>. To uninstall Lean, see
`lean/04_example1/README.md`.

What two of these commands do:

- `code --install-extension leanprover.lean4` installs the official Lean 4 extension (publisher `leanprover`) into
  VS Code from a terminal, the same as searching "Lean 4" in VS Code's Extensions view. `code` is VS Code's
  command-line launcher. On macOS, add it once from VS Code's Command Palette (Cmd+Shift+P):
  "Shell Command: Install 'code' command in PATH".
- Docker runs a small Linux system, a *container*, on a Mac. Its background service, the *Docker daemon*, runs the
  containers. It starts with Docker Desktop (`open -a Docker`), and on Linux with `sudo systemctl start docker`.
  Only Comparator needs it, because Comparator's sandbox needs Linux.

## Running Lean, MATLAB, and Julia

- **Lean in VS Code:** open a project folder (File, Open Folder), then any `.lean` file in it. There is no Run button:
  the Lean 4 extension checks the file as you type, underlines errors in red, and shows the goals and the output of
  `#eval` and `#print` in the *Infoview* (toggle it with Cmd+Shift+Enter, Ctrl+Shift+Enter on Windows and Linux).
  The extension's commands, such as restarting the file, are in the ∀ menu at the top right of the editor.
- **Lean in a terminal:** `lake build` compiles the whole project, `lake env lean FILE.lean` checks one file and
  prints its messages, and `lake exe NAME` runs a program such as `helloworld`. In a project folder, `make` lists the
  targets of its `Makefile` that run these commands: `make build`, `make check`, `make compare` (Comparator), and
  `make clean`.
- **Lean in a browser, without installing:** Lean 4 Web, <https://live.lean-lang.org>, with Mathlib, for small
  files. Its README suggests a cloud setup such as GitHub Codespaces for whole projects.
- **MATLAB in a browser:** MATLAB Online, <https://matlab.mathworks.com>, free for 20 hours a month with a
  MathWorks account. Upload `matlab/eg1.m` and `eg2.m` and run them.
- **Julia in a browser:** a Pluto notebook at <https://binder.plutojl.org> (free, through mybinder.org), or a
  simple online compiler such as JDoodle. `eg1.jl` and `eg2.jl` need only the standard library, while
  `lift_demo.jl` needs the pinned Krylov.jl and so a local install.

All Lean files here were compiled on 2026-11-13 with Lean 4.35.0 (Mathlib v4.35.0 for `lean/04_example1/` and
`lean/03_my_proofs/`), and Comparator accepted all 15 completed teaching theorems in six kernel configurations.
Use `make compare` for supplied proofs, and `make compare-exercises` in `03_my_proofs/`
for the learner's own completed handout; unfinished `sorry` proofs are rejected.

## Contact

Questions, comments, and collaboration: <https://www.linkedin.com/in/sou-cheng-choi-7682b65/> (LinkedIn), or open an issue in this repository.

## AI assistance

Anthropic Claude (<https://www.anthropic.com/claude>) generated the Lean files beyond what `lake new` wrote, and
helped write the MATLAB and Julia scripts and the READMEs. Lean's kernel checks every proof, and the author is
responsible for all content.

## License and citation

Apache License 2.0 (`LICENSE`), the license of Lean and Mathlib. To cite this code, see `CITATION.cff`.
