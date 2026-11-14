# First proof and three exercises. "make" lists the targets. Run it in this folder.
# Make prints each command before it runs it, so you see the lake commands.

COMPARE = lake build MyProofs Challenge && lake comparator --paranoid --config my_proofs.json
COMPARE_EXERCISES = lake build MyProofs.Exercises Challenge && lake comparator --paranoid --config my_exercises.json

.PHONY: help cache build check compare compare-exercises clean distclean

help:
	@echo "make cache      download prebuilt Mathlib, once (about 7 GB): lake exe cache get"
	@echo "make build      compile First.lean and Solutions.lean: lake build"
	@echo "make check      check your Exercises.lean: lake env lean MyProofs/Exercises.lean"
	@echo "make compare    Comparator: check the first proof and all three supplied solutions"
	@echo "make compare-exercises  Comparator: check YOUR Exercises.lean; rejects unfinished proofs"
	@echo "make clean      delete the build output, keep Mathlib: lake clean my_proofs"
	@echo "make distclean  delete Mathlib too (.lake, about 7 GB): rm -rf .lake"

cache:
	lake exe cache get

build:
	lake build

check:
	lake env lean MyProofs/Exercises.lean

compare:
ifeq ($(shell uname -s),Linux)
	$(COMPARE)
else
	../docker/run.sh '$(COMPARE)'
endif

compare-exercises:
ifeq ($(shell uname -s),Linux)
	$(COMPARE_EXERCISES)
else
	../docker/run.sh '$(COMPARE_EXERCISES)'
endif

clean:
	lake clean my_proofs

distclean:
	rm -rf .lake
