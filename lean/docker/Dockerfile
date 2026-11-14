# A Linux image for Comparator, which needs Linux. run.sh builds it. Two stages:
#   lean     Lean from lean-toolchain, and bubblewrap (Comparator's sandbox): for projects without Mathlib
#   mathlib  lean plus prebuilt Mathlib: for projects with Mathlib
# lakefile.toml, lake-manifest.json, and lean-toolchain next to this file are those of ../04_example1.
FROM ubuntu:24.04 AS lean
RUN apt-get update && apt-get install -y --no-install-recommends git curl ca-certificates bubblewrap build-essential xz-utils zstd \
 && rm -rf /var/lib/apt/lists/*
# bubblewrap needs the folder /run/user/UID of the user that runs Comparator
RUN useradd -m -u 1001 lean && mkdir -p /run/user/1001 && chown lean:lean /run/user/1001
USER lean
WORKDIR /home/lean
ENV PATH=/home/lean/.elan/bin:$PATH
COPY --chown=lean:lean lean-toolchain /home/lean/
RUN curl -sSf https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh | sh -s -- -y --default-toolchain none \
 && elan toolchain install "$(cat lean-toolchain)" && elan default "$(cat lean-toolchain)"

FROM lean AS mathlib
COPY --chown=lean:lean lakefile.toml lake-manifest.json lean-toolchain /home/lean/proj/
WORKDIR /home/lean/proj
# the download can fail on a bad connection, so it is tried three times, and its cache is deleted after the unpacking
RUN (lake exe cache get || lake exe cache get || lake exe cache get) && rm -rf /home/lean/.cache/mathlib
