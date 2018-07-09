function [ H, T, R ] = myhough( bw, rs )
%   Assume img is already BW otherwise it'll break
%   rs: rho resolution
    D = sqrt((size(bw, 1) - 1)^2 + (size(bw,2) - 1)^2);
    diagonal = rs*ceil(D/rs);
    nrho = 2*(ceil(D/rs)) + 1;
    R = -diagonal:rs:diagonal;
    T = -90:1:89;
    H = zeros(length(R), length(T)); %hough transform
    for x = 1:size(bw,2)
        for y = 1:size(bw,1)
            if not(bw(y,x)); continue; end;
            for th=T
                true_rho = (x-1)*cos(deg2rad(th)) + (y-1)*sin(deg2rad(th)); %real distance
                rho = rs * ceil(true_rho/rs); % fit true rho to one of the discrete rho bins
                rh = (diagonal + rho)/rs + 1; th = 91 + th; %find the index in H of the \rho and \theta values
                H(rh, th) = H(rh, th) + 1;
            end
        end
    end
    
end

