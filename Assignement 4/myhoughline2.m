function line = myhoughline2( img, rho, theta )
    
    if theta == 0
       y = @(x) linspace(0, size(img,1));
       x = rho * ones(1, length(linspace(0, size(img,1))));
    else
        y = @(x) -x*cos(deg2rad(theta))/sin(deg2rad(theta)) + rho/sin(deg2rad(theta)); %equation of the line
        x = linspace(0, size(img,2));
    end  
    
    line = [x;y(x)];
end

