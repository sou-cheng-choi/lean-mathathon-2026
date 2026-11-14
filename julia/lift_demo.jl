# Numbers quoted in lean_talk.qmd: the minimum-norm lift x - conj(r)(r^T x)/||r||^2 applied by hand to
# the stationary iterate of minares(...; complex_symmetric=true). Needs a Krylov.jl whose minares
# has the complex_symmetric option but no built-in lift (the lift is applied here explicitly):
#
#  julia --project=PATH/TO/Krylov.jl-pin8af001ea3-minres lift_demo.jl   (run from this folder)

using Krylov, LinearAlgebra, Random, Printf

lift(x, r) = x - conj(r) * (transpose(r) * x) / norm(r)^2

function report(name, A, b)
  xmn = pinv(Matrix(A)) * b                          # minimum-norm least-squares solution
  x, stats = minares(A, b; complex_symmetric=true)
  r = b - A * x
  xl = lift(x, r)
  @printf("%-34s niter=%d  ||A'r||=%.4e\n", name, stats.niter, norm(A' * r))
  @printf("  before lift: ||x-x_mn||/||x_mn||=%.4e  ||r||=%.4e\n", norm(x - xmn) / norm(xmn), norm(r))
  @printf("  after  lift: ||x-x_mn||/||x_mn||=%.4e  ||r||=%.4e\n", norm(xl - xmn) / norm(xmn), norm(b - A * xl))
  return x, xl, xmn
end

# 1. Two by two, by hand on the slides (Example 2 reuses Example 1's data): A = [1 1+i; 1+i 2i],
#    b = (1,0), x_mn = (1/9)(1, 1-i).
A2 = ComplexF64[1 1+im; 1+im 2im]
b2 = ComplexF64[1, 0]
x, xl, = report("n=2, Example 1's A and b", A2, b2)
println("  x = ", x, "   lifted = ", xl)

# 2. n=5, rank 3, complex symmetric A = F*Diagonal(sigma)*transpose(F) with F the DFT matrix; b not in range(A).
n = 5
F = [cispi(-2 * (j * k) / n) / sqrt(n) for j = 0:n-1, k = 0:n-1]
A5 = F * Diagonal([3.0, 2.0, 1.0, 0.0, 0.0]) * transpose(F)
b5 = A5 * ComplexF64.(1:n) + F[:, 4]
report("n=5, rank 3, b outside range(A)", A5, b5)

# 3. n=10, nonsingular but ill-conditioned (sigma from 1 to 1e-4): the lift must NOT be applied.
rng = MersenneTwister(10)
Q = Matrix(qr(randn(rng, ComplexF64, 10, 10)).Q)
A10 = Q * Diagonal(exp10.(range(0, -4, length=10))) * transpose(Q)
b10 = randn(rng, ComplexF64, 10)
report("n=10, nonsingular, cond 1e4", A10, b10)
