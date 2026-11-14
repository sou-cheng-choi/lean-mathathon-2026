% Example 1 of lean_talk.qmd (slide 3). Run: matlab -batch eg1
% The Julia version is ../julia/eg1.jl. A' is the conjugate transpose, A.' the plain transpose.
A = [1, 1+1i; 1+1i, 2i];     % complex symmetric
b = [1; 0];

issymmetric(A)                % 1: A.' equals A (plain transpose)
ishermitian(A)                % 0: A' does not equal A (conjugate transpose)
rank(A)                       % 1, so A is singular

x = pinv(A)*b                 % minimum-norm least-squares solution, x-dagger
                              % = [0.1111 + 0.0000i; 0.1111 - 0.1111i] = (1/9)*[1; 1-1i]
                              % lsqminnorm(A,b) gives the same x (R2017b and later)
r = b - A*x                   % [0.6667; -0.3333 - 0.3333i], nonzero: Ax = b has no solution
norm(A'*r)                    % about 1e-15: x is a least-squares solution
[1; 1+1i].'*x                 % 0.3333 = 1/3: x1 + (1+i)*x2 = 1/3 for every minimizer

norm(r)                       % 0.8165 = sqrt(2/3): the minimum residual norm
norm(x)                       % 0.1925 = 1/sqrt(27): the minimum solution norm
x1 = 1/3;  y = [x1; (1/3 - x1)/(1+1i)];   % another minimizer: x1 any complex number
norm(b - A*y)                 % 0.8165, the same residual norm
norm(y)                       % 0.3333 > norm(x): not the minimum solution norm
