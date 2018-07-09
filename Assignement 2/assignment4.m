clear;clc;cla;

positions = zeros(1000000,1);
for player = 1:1000000
    for turn = 1:100
        positions(player) = positions(player) + mod(randi(2),2);
    end
end

%% Plotting
figure;
histogram(positions);
xlabel('End position');
ylabel('Count');
title('Distribution of end positions');