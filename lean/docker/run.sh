#!/bin/sh
# Run a command on a copy of the current project folder, in a Linux container.
# Usage, from a project folder:  ../docker/run.sh 'lake build X Challenge && lake comparator --paranoid --config c.json'
# The first call builds the image (Lean only: about 8 minutes, with Mathlib: about 12, mostly downloads). Docker must be running.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
export PATH=/Applications/Docker.app/Contents/Resources/bin:$PATH   # Docker Desktop on macOS
command -v docker >/dev/null || { echo "Docker is not installed. See Install in ../../README.md."; exit 1; }
docker info >/dev/null 2>&1 || { echo "Docker is not running. On macOS: open -a Docker, and wait until docker info answers."; exit 1; }
if grep -q mathlib lakefile.toml; then
  image=lean-cmp-mathlib target=mathlib dir=/home/lean/proj   # the image's Mathlib project, with the files copied over it
else
  image=lean-cmp target=lean dir=/home/lean/p
fi
if ! docker image inspect "$image" >/dev/null 2>&1; then
  echo "Building the Docker image $image (once)."
  ctx=$(mktemp -d)
  trap 'rm -rf "$ctx"' EXIT
  cp "$here/Dockerfile" "$here/../04_example1/lakefile.toml" "$here/../04_example1/lake-manifest.json" "$here/../04_example1/lean-toolchain" "$ctx"
  docker build --target "$target" -t "$image" "$ctx"
fi
# The flags let bubblewrap, Comparator's sandbox, start inside the container.
docker run --rm -v "$PWD":/mnt/p:ro \
  --security-opt seccomp=unconfined --security-opt apparmor=unconfined \
  --security-opt systempaths=unconfined --cap-add SYS_ADMIN "$image" \
  bash -c 'mkdir -p "$1" && tar -C /mnt/p --exclude=.lake --exclude=.git -cf - . | tar -C "$1" -xf - && cd "$1" && bash -c "$2"' _ "$dir" "$*"
