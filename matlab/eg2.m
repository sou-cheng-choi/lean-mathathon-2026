% Example 2 of lean_talk.qmd (slide 6). Run: matlab -batch eg2
% The Julia version is ../julia/eg2.jl. Example 1's A and b again: the first iterate is stationary,
% yet not x-dagger, and the lift fixes that. A' is the conjugate transpose, r.' the plain transpose.
A = [1, 1+1i; 1+1i, 2i];  b = [1; 0];     % Example 1's complex symmetric A and b
xdag = pinv(A)*b              % (1/9)*[1; 1-1i] = [0.1111; 0.1111 - 0.1111i]

v = conj(b);                  % the trial space is span{conj(b)}
t = (A*v)\b;                  % minimize norm(b - A*(t*v)) over t: t = 1/3
x1 = t*v                      % [0.3333; 0]
r = b - A*x1                  % (1/3)*[2; -1-1i] = [0.6667; -0.3333 - 0.3333i]
norm(A'*r)                    % about 1e-16: x1 is stationary
[norm(x1)^2, norm(xdag)^2]    % [0.1111, 0.0370] = [1/9, 1/27]: yet x1 is not x-dagger

c = (r.'*x1)/norm(r)^2        % 0.3333 = (2/9)/(2/3), the lift coefficient (r.' is the plain transpose)
x = x1 - conj(r)*c            % (1/9)*[1; 1-1i]: the lift gives x-dagger
norm(x - xdag)                % about 1e-16
