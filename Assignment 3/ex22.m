load lab3_2.mat;

max_K = 199;

mcr = zeros(1,max_K);
data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) )';

for K = 1:max_K
    for i = 1:length(data)
        data_copy = data;
        data_copy(i,:) = [];
        
        class_copy = class_labels;
        class_copy(i) = [];
        
        xtest = data(i,:);
        ytest = class_labels(i);
        
        res = KNN(xtest, K, data_copy, class_copy);
        
        if res ~= ytest
            mcr(K) = mcr(K) + 1;
        end
    end
end

mcr = mcr / length(data);

plot(1:max_K, mcr);
xlabel('K');
ylabel('Error rate');
title('Classification error using 2-class KNN');