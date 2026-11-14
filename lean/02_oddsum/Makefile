# Sum of the first n odd numbers, in core Lean (no Mathlib). "make" lists the targets. Run it in this folder.
# Make prints each command before it runs it, so you see the lake commands.

# Comparator needs Linux. On other systems, ../docker/run.sh runs the same command in a Linux container.
COMPARE = lake build Oddsum Challenge && lake comparator --paranoid --config oddsum.json

.PHONY: help build check compare clean

help:
	@echo "make build    compile the proof: lake build"
	@echo "make check    print the axioms of sum_of_odds_equals_square: lake env lean Axioms.lean"
	@echo "make compare  Comparator: does Oddsum prove the statement of Challenge.lean?"
	@echo "make clean    delete the build output: lake clean"

build:
	lake build

check:
	lake env lean Axioms.lean

compare:
ifeq ($(shell uname -s),Linux)
	$(COMPARE)
else
	../docker/run.sh '$(COMPARE)'
endif

clean:
	lake clean
