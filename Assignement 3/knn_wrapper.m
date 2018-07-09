clear all;
load lab3_2.mat;

K=5;
samples=64;
data = lab3_2;
nr_of_classes = 4;

% Class labels
% class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

%alternative class labels for qs 8-10
class_labels = floor( (0:length(data)-1)/50);


% Sample the parameter space
result=zeros(samples);
for i=1:samples
  X=(i-1/2)/samples;
  for j=1:samples
    Y=(j-1/2)/samples;
    result(j,i) = KNN([X Y],K,data,class_labels);
  end;
end;

% Show the results in a figure
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
plot(scaled_data(  1:100,1),scaled_data(  1:100,2),'go');
plot(scaled_data(101:200,1),scaled_data(101:200,2),'r+');


%% cv error as function of K
cvs = zeros(size(data,1)-1, 1);
for i = 1:size(data, 1)-1
    cvs(i) = loocv(data, class_labels, i);
end
figure
hold on
plot([1:size(data,1)-1], cvs);
xlabel('K');
ylabel('Error');
title('Classification error as function of K for 4 classes');
grid on;

cv3 = cvs(3);
cv17 = cvs(17);
[minCvError, bestK] = min(cvs);
