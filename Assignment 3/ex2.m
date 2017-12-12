load lab3_2.mat;

max_K = 199;

mcr = zeros(1,max_K);
data = lab3_2;
nr_of_classes = 2;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) )' + 1;

for K = 1:max_K
    regf=@(XTRAIN,ytrain,XTEST)(KNN(XTEST, K, XTRAIN, ytrain));
    
    mcr(K) = crossval('mcr',data,class_labels,'predfun',regf, 'leaveout', 1);
end

plot(1:max_K, mcr);
xlabel('K');
ylabel('Error rate');