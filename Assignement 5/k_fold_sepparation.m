function [ out_data, out_labels ] = k_fold_sepparation( data, labels, k )
    
    data_order = randperm(length(data));
    labels_order = randperm(length(labels));
    data = data(data_order,:);
    labels = labels(labels_order);
    step = ceil(length(data)/k);
    
    out_data = {};
    out_labels = {};
    for i = 1:step:length(data)
        index = ceil(i/step);
        out_data{index} = data(i:i+step-1,:);
        out_labels{index} = labels(i:i+step-1,:);
    end

end

