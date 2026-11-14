# Example 1 and Example 2 in Lean, and Comparator. "make" lists the targets. Run it in this folder.
# Make prints each command before it runs it, so you see the lake commands.

# Comparator needs Linux. On other systems, ../docker/run.sh runs the same command in a Linux container.
COMPARE = lake build Example1 Challenge && lake comparator --paranoid --config all_examples.json

.PHONY: help cache build check compare clean distclean

help:
	@echo "make cache      download prebuilt Mathlib, once (about 7 GB): lake exe cache get"
	@echo "make build      compile Examples 1 and 2 and print their axiom dependencies: lake build"
	@echo "make check      compile Example 2 and print the axioms of lift_gives_minimum_norm: lake env lean Example1/Lift.lean"
	@echo "make compare    Comparator: does Example1 prove the statements of Challenge.lean?"
	@echo "make clean      delete the build output, keep Mathlib: lake clean example1"
	@echo "make distclean  delete Mathlib too (.lake, about 7 GB): rm -rf .lake"

cache:
	lake exe cache get

build:
	lake build

check:
	lake env lean Example1/Lift.lean

compare:
ifeq ($(shell uname -s),Linux)
	$(COMPARE)
else
	../docker/run.sh '$(COMPARE)'
endif

clean:
	lake clean example1

distclean:
	rm -rf .lake
