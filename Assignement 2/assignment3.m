clear;clc;
mu = [3;4];
Sigma = [1 0; 0 2];

x1 = -10:.3:10; x2 = -10:.3:10;
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu',Sigma);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
% caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([-10 10 -10 10 0 .4])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');

% mahalanobis distance
SigmaInv = inv(Sigma);
r1 = sqrt(([10;10]-mu)'*SigmaInv*([10;10]-mu))
r2 = sqrt(([0;0]-mu)'*SigmaInv*([0;0]-mu))
r3 = sqrt(([3;4]-mu)'*SigmaInv*([3;4]-mu))
r4 = sqrt(([6;8]-mu)'*SigmaInv*([6;8]-mu))

