load lab3_3_cat1.mat;
load lab3_3_cat2.mat;
load lab3_3_cat3.mat;

h = 1;

u = [0.5 1.0 0.0];
v = [.31 1.51 -.5];
w = [-1.7 -1.7 -1.7];

pts = [u; v; w];
xs = [x_w1, x_w2, x_w3];

phi = @(x, xj)(exp(-sum((x - xj).^2)/(2*h^2)));

p = zeros(3, 3);

for pt = 1:3
    point = pts(pt,:);
    for k = 1:3
        cls = xs(:,3*(k - 1) + 1:3*k);
        
        dens = 0;
        for i = 1:10
            dens = dens + phi(point, cls(i,:));
        end
        
        p(pt,k) = dens;
    end
    
end

p = p / (h*sqrt(2*pi))^3 / 10;

post = @(pt, cls)(p(pt, cls) * (1/33) / (1/3));

clf
scatter3(x_w1(:,1), x_w1(:,2), x_w1(:,3))
hold on
scatter3(x_w2(:,1), x_w2(:,2), x_w2(:,3), '.')
scatter3(x_w3(:,1), x_w3(:,2), x_w3(:,3), 'v')

plot3(u(1), u(2), u(3), '+')
plot3(v(1), v(2), v(3), '*')
plot3(w(1), w(2), w(3), 'x')
