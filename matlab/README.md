# matlab: Examples 1 and 2 in MATLAB

Easily reproducible (ER): each script needs only MATLAB (no toolbox) and runs in seconds.

| File | Slide | What it shows |
| --- | --- | --- |
| `eg1.m` | 3, The Problem | Example 1: `A` is complex symmetric, not Hermitian, and singular. `pinv(A)*b` is x-dagger |
| `eg2.m` | 6, Check It by Hand | Example 2: the first iterate is stationary but not x-dagger, and the lift fixes that |

## Step by step

1. Install MATLAB (a license is needed): <https://www.mathworks.com/products/matlab.html>.
2. From this folder, in a terminal:

       matlab -batch eg1       # prints the checks of Example 1
       matlab -batch eg2       # prints iterate, r, c, and the lifted x, equal to x-dagger

   Or, inside MATLAB, `cd` to this folder and type `eg1` and then `eg2`.

Without a local MATLAB: MATLAB Online (<https://matlab.mathworks.com>) is free for 20 hours a month with a
MathWorks account. Upload the two files and type `eg1` and `eg2` in its Command Window.

The same two examples in Julia are in `../julia/`.
