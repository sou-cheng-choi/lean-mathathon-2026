# docker: Comparator on a Mac

Comparator's sandbox needs Linux (it uses `bubblewrap`). On Linux, `make compare` runs Comparator directly. On macOS,
and on Windows without WSL, the Makefiles of `../04_example1/` and `../02_oddsum/` call `run.sh` here instead, which runs the
same commands in a Linux container with Docker. Start Docker Desktop first (`open -a Docker`), and wait until
`docker info` answers.

| File | What it is |
| --- | --- |
| `Dockerfile` | Ubuntu 24.04 with Lean 4.35.0 and `bubblewrap` (stage `lean`), and a second stage `mathlib` that adds prebuilt Mathlib `v4.35.0`. It copies `lakefile.toml`, `lake-manifest.json`, and `lean-toolchain` of `../04_example1/`, which pin that Mathlib |
| `run.sh` | Builds the image on first use, copies the current project folder (without `.lake`) into a new container, runs the command you give it there, and deletes the container |

## Images

| Image | For | Size | First build here |
| --- | --- | --- | --- |
| `lean-cmp` | Projects without Mathlib (`../02_oddsum/`) | 3.6 GB | 8 minutes, mostly the 600 MB download of Lean |
| `lean-cmp-mathlib` | Projects with Mathlib (`../04_example1/`) | 10.9 GB | 12 minutes, mostly downloads |

`run.sh` picks the image by looking for `mathlib` in the project's `lakefile.toml`. Later runs build nothing.
Remove the images with `docker rmi lean-cmp lean-cmp-mathlib`.

## Run by hand

From a project folder, here `../04_example1/`:

    ../docker/run.sh 'lake build Example1 Challenge && lake comparator --paranoid --config example1.json'

`run.sh` runs any command on a copy of the folder, so `../docker/run.sh 'lake build'` compiles it in Linux.

## The flags of docker run

`seccomp=unconfined`, `apparmor=unconfined`, and `--cap-add SYS_ADMIN` let `bubblewrap` create user namespaces inside
the container, and `systempaths=unconfined` lets it mount `/proc`. They weaken the container's own isolation, so run
only code you trust. The project folder is mounted read only, and the container is deleted after each run.
