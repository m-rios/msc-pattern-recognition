clear; clc; close all;

x1 = [0 0];
x2 = [2 3];
x3 = [1 4];
x4 = [4 2];
x5 = [3 0];


%% Question 1

Q1 = Je({[x1;x2;x3],[x4;x5]})

Q2 = Je({[x2;x3;x5],[x1;x4]})

Q3 = Je({[x4],[x1;x2;x3;x5]})

Q4 = Je({[x3;x5],[x1;x2;x4]})



%% Functiond definition

function [M] = Je(C)
    M = 0
    for i=1:length(C)
        Di = C{i};
        n = size(Di,1);
        if n > 1
            mi = sum(Di)/n;
        else
            mi = Di
        end
%         mi = mean(Di);
        for x=1:n
            M = M + norm(Di(x,:)-mi)^2;
        end
    end
end