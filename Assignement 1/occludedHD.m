function [ HD ] = occludedHD( p1, p2 )
%NORMALHD Summary of this function goes here
%   Detailed explanation goes here
%   get the mask for p1 & p2
    if size(p1,2) ~= size(p2,2)
        return;
    end
    mask1 = [];
    mask2 = [];
    for i = 1:size(p1,2)
        mask1 = [mask1, p1(i) ~= 2];
        mask2 = [mask2, p2(i) ~= 2];
    end
    
    HD = sum(xor(p1, p2) & mask1 & mask2)/sum(mask1 & mask2);

end

