# julia: Examples 1 to 4 in Julia

| File | Slides | Reproducibility | What it shows |
| --- | --- | --- | --- |
| `eg1.jl` | 3, The Problem | ER: Julia standard library only | Example 1, as `../matlab/eg1.m` |
| `eg2.jl` | 6, Check It by Hand | ER: Julia standard library only | Example 2, as `../matlab/eg2.m` |
| `lift_demo.jl` | 6 and 32, What Lean Does Not Say | CR: needs a pinned Krylov.jl | The relative errors before and after the lift for Examples 2 to 4 |

## Step by step

1. Install Julia (any recent version, 1.12.6 was used):

       curl -fsSL https://install.julialang.org | sh

2. Examples 1 and 2, from this folder:

       julia eg1.jl            # norm(x - pinv(A)*b) and the other checks of Example 1
       julia eg2.jl            # c = 1/3, and norm(x - xdag) about 1e-16 after the lift

3. Examples 2 to 4 with Krylov.jl (conditionally reproducible): `lift_demo.jl` needs a Krylov.jl whose
   `minares` has the option `complex_symmetric` but no built-in lift, the checkout
   `Krylov.jl-pin8af001ea3-minres`: Krylov.jl at commit 8af001ea3 plus one local commit (5e4972f7b, not public)
   that adds `complex_symmetric` to `minres.jl`. From this folder, with the checkout's path:

       julia --project=PATH/TO/Krylov.jl-pin8af001ea3-minres lift_demo.jl

   Here the checkout sits three levels up: `julia --project=../../../Krylov.jl-pin8af001ea3-minres lift_demo.jl`.

Without a local Julia: `eg1.jl` and `eg2.jl` use only the standard library, so they also run in a Pluto notebook at
<https://binder.plutojl.org> (free, through mybinder.org) or in a simple online compiler such as JDoodle
(<https://www.jdoodle.com/online-compiler-julia>). `lift_demo.jl` needs the pinned Krylov.jl, so run it locally.

`eg1.jl` and `eg2.jl` were run on 2026-11-12 with Julia 1.12.6.
