# Example 2 of lean_talk.qmd (slide 6), the Julia version of ../matlab/eg2.m. Run: julia eg2.jl
# Example 1's A and b again: the first iterate is stationary, yet not x-dagger, and the lift fixes that.
# Standard library only. A' is the conjugate transpose (MATLAB A'), transpose(r) the plain one (MATLAB r.').
using LinearAlgebra

A = ComplexF64[1 1+im; 1+im 2im]       # Example 1: complex symmetric, rank 1
b = ComplexF64[1, 0]
@show xdag = pinv(A) * b               # (1/9)*[1, 1-im] = [0.1111, 0.1111 - 0.1111im]

v = conj(b)                            # the trial space is span{conj(b)}
t = (A * v) \ b                        # minimize norm(b - A*(t*v)) over t: t = 1/3
@show x1 = t * v                       # [0.3333, 0]
@show r = b - A * x1                   # (1/3)*[2, -1-im] = [0.6667, -0.3333 - 0.3333im]
@show norm(A' * r)                     # about 1e-16: x1 is stationary
@show [norm(x1)^2, norm(xdag)^2]       # [1/9, 1/27] = [0.1111, 0.0370]: yet x1 is not x-dagger

@show c = transpose(r) * x1 / norm(r)^2   # 1/3 = (2/9)/(2/3), the lift coefficient
@show x = x1 - conj(r) * c             # (1/9)*[1, 1-im]: the lift gives x-dagger
@show norm(x - xdag)                   # about 1e-16
