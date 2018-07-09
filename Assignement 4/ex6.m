f = imread('dogGrayRipples.png');

Y = fft2(f);
Y_s = fftshift(Y);

p1 = [167 121];
p2 = [167 181];
radius = 10;
strength = 2.0;

for i = 100:200
    for j = 100:200
        dP1 = sqrt(double(i-p1(2))^2 + double(j-p1(1))^2);
        dP2 = sqrt(double(i-p2(2))^2 + double(j-p2(1))^2);
        
        if dP1 < radius
            Y_s(i,j) = Y_s(i,j) * (dP1 / strength / radius);
        elseif dP2 < radius
            Y_s(i,j) = Y_s(i,j) * (dP2 / strength / radius);
        end
    end
end

imagesc(log(abs(Y_s) + 1));
%% Inverse Fourier transform
Y_t = ifftshift(Y_s);
g = real(ifft2(Y_t));
clf;
colormap(gray(256));
imagesc(g);
axis tight;

imwrite(g/256, 'dogRetouched.png');