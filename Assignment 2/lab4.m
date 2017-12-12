%% Data generation
n = 100;        % amount of turns
m = 1000000;    % number of people

positions = zeros(1, m);

for i = 1:n
    positions = positions + randi([0 1], 1, m);
end

%% Plotting
histogram(positions);
xlim([0 100]);
xlabel('End position');
ylabel('Frequency');
title('Distribution of end positions');