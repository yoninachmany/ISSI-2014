function [  ] = FullRansac( fn1, fn2 )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
close all;
run('D:\vlfeat-0.9.16\toolbox\vl_setup.m');

[XSIFT, YSIFT, X_SIFT, Y_SIFT] = SIFT(fn1, fn2);
figure(1);
DRAW(fn1, fn2, XSIFT, YSIFT, X_SIFT, Y_SIFT, [], []);


%change the parameters - number of triples to sample, threshold of RANSAC

thresh = 1;
%thresh = [3, 10]; %depending on accuracy or number of points wanted
iter = 1000;
for i = 1:length(thresh)
    [X, Y, X_, Y_, TXY, bestT, bestNorm] = RANSAC(XSIFT, YSIFT, X_SIFT, Y_SIFT, thresh(i), iter);
    figure(i+1);
    inliers = find(bestNorm < (thresh(i) * ones(1, size(bestNorm, 2))));
    DRAW(fn1, fn2, X(inliers), Y(inliers), X_(inliers), Y_(inliers), TXY(:, inliers), bestT);
end

