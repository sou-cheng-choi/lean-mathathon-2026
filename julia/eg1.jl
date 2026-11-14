# Example 1 of lean_talk.qmd (slide 3), the Julia version of ../matlab/eg1.m. Run: julia eg1.jl
# Standard library only. A' is the conjugate transpose (MATLAB A'), transpose(A) the plain one (MATLAB A.').
using LinearAlgebra

A = ComplexF64[1 1+im; 1+im 2im]       # complex symmetric
b = ComplexF64[1, 0]

@show issymmetric(A)                   # true: transpose(A) equals A
@show ishermitian(A)                   # false: A' does not equal A
@show rank(A)                          # 1, so A is singular

@show x = pinv(A) * b                  # minimum-norm least-squares solution, x-dagger
                                       # = [0.1111 + 0.0im, 0.1111 - 0.1111im] = (1/9)*[1, 1-im]
@show r = b - A * x                    # [0.6667 + 0.0im, -0.3333 - 0.3333im], nonzero: Ax = b has no solution
@show norm(A' * r)                     # about 1e-15: x is a least-squares solution
@show transpose([1, 1+im]) * x         # 0.3333 = 1/3: x1 + (1+i)*x2 = 1/3 for every minimizer

@show norm(r)                          # 0.8165 = sqrt(2/3): the minimum residual norm
@show norm(x)                          # 0.1925 = 1/sqrt(27): the minimum solution norm
x1 = 1/3                               # another minimizer: x1 any complex number
y = [x1, (1/3 - x1)/(1+im)]
@show norm(b - A * y)                  # 0.8165, the same residual norm
@show norm(y)                          # 0.3333 > norm(x): not the minimum solution norm
