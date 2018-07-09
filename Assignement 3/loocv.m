function [ E ] = loocv( data, labels, K )
    accum = 0;
    for i = 1:size(data,1)
        training_data = data;
        training_data(i,:) = [];
        training_labels = labels;
        training_labels(i) = [];
        accum = accum + (KNN(data(i,:), K, training_data, training_labels) ~= labels(i));
    end
    E = accum / size(data, 1);
end

