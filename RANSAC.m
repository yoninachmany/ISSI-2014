function [ X, Y, X_, Y_, TXY, bestT, bestNorm ] = RANSAC( X, Y, X_, Y_, thresh, n ) 
%RANSAC Random Sample Consensus
%   Finding image transformations
%   July 9-10, 2014

max = 0;
bestT = zeros(3);
bestNorm = Inf * ones(1, size(X, 2));

for i = 1:n %repeat for N rounds
    %select three matches at random
    r = ceil((length(X)) * rand(1,3));
    x = X(r);
    y = Y(r);
    x_ = X_(r);
    y_ = Y_(r);

    %fit an affine transformation T
    
    %for precision, check determinant distance from zero
    if abs(det([x; y; 1, 1, 1])) < 10^(-8)
        continue;
    end
    
    A = [x_; y_]/[x; y; 1, 1, 1];
    T = [A; 0, 0, 1];

    p = [X; Y; ones(1, length(X))];
    q = [X_ ; Y_; ones(1, length(X_))];
    
    %count the inliers
    diff = T * p - q;
    norm = sqrt(sum(diff .^ 2)); %norm 2
    inliers = numel(find(norm < (thresh * ones(1, size(norm, 2)))));

    %if T has the highest number of inliers so far, save it
    if inliers > max
        max = inliers;        
        bestT = T;
        bestNorm = norm;
    end
end

TXY = bestT * [X; Y; ones(1,size(X, 2))];

end
