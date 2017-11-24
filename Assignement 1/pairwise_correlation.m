function [ c ] = pairwise_correlation( a, b )
%     Standard deviation for each feature
    sa = std(a);
    sb = std(b);
%     Covariance of the features
    cab = cov(a, b);
%     Pairwise correlation between the two features
    c = cab(1,2)/(sa*sb);

end

