# Hello World project. "make" lists the targets. Run it in this folder.
# Make prints each command before it runs it, so you see the lake commands.

.PHONY: help build run clean

help:
	@echo "make build   compile the library and the program: lake build"
	@echo "make run     build, then run the program: lake exe helloworld"
	@echo "make clean   delete the build output: lake clean"

build:
	lake build

run: build
	lake exe helloworld

clean:
	lake clean
