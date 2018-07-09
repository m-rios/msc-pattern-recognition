function [ w, ws ] = initialise_w( data )

mu = [mean(data(:,1)), mean(data(:,2))];
Sigma = [std(data(:,1)), std(data(:,2))];
randw = @() [randn * Sigma(1) + mu(1), randn * Sigma(2) + mu(2)];
w = [randw();randw();randw();randw()];
ws = [0;0;1;1];

end

