clear;clc;cla;

%% dist 1


m1 = [3;5];
S1 = [1 0; 0 4];

p1 = .3;

a = sym('a',[2,1]);


% p = 1/((2*pi) * sqrt(det(Sigma)))*exp( -1/2 * (a - mu)' * inv(Sigma) * (x - mu) );

p = mvnpdf(a, m1, S1);

g1 = log(p) + log(p1);

assume(a, 'real');
g1 = vpa(expand(simplify(g1,4)))

%% dist 2

m2 = [2;1];
S2 = [2 0; 0 1];
p2 = .7;

a = sym('a',[2,1]);

p = mvnpdf(a, m2, S2);

g2 = log(p) + log(p2);

assume(a, 'real');
g2 = vpa(expand(simplify(g2,4)))

%% Decision boundary

g = g1-g2;

gf = @(a1,a2) - 0.25*a1^2 + 2.0*a1 + 0.375*a2^2 + 0.25*a2 - 7.3188714506671762594081087627274;

%% Plotting

[X, Y] = meshgrid(-10:0.5:10, -10:0.5:10);
F_1 = mvnpdf([X(:), Y(:)], m1', S1);
F_2 = mvnpdf([X(:), Y(:)], m2', S2);

F = max(F_1, F_2);
F_res = reshape(F, length(Y), length(X));
figure(1);
hold on;
% mesh(X, Y, F_res);
contour(X,Y,F_res);
xlabel('X');
ylabel('Y');
zlabel('Probability Density');

fimplicit(gf, [-10 20 -10 20])
