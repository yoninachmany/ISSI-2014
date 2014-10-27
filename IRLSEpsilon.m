function [ A ] = IRLSEpsilon( fn1, fn2, X, Y, X_, Y_, lowW, yEpsilon )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

A = [1 0 0; 0 1 0; 0 0 0]; %changeable
maxIter = 200; %changeable
minDelta = 0.1; %changeable
delta = norm([max(X)-min(X); max(Y)-min(Y)])/4; %changeable
deltaFactor = 0.5; %changeable
iter = 1;
epsilon = 10^-5; %changeable
p = 0.01; %changeable

P = [X; Y; ones(1, size(X, 2))];
Q = [X_; Y_; ones(1, size(X_, 2))];

diff = A * P - Q; % later, A * P + D - Q
Norm = sqrt(sum(diff .^ 2)); %norm 2
W = (Norm.^2 + delta) .^ (p/2 - 1);
func = inf * ones(size(maxIter));

func(iter) = sum((Norm.^2 + delta) .^ (p/2));
iter = iter + 1;

while iter < maxIter && minDelta < delta
    [A, TXY, D] = solveEpsilon(W, P, Q, yEpsilon);
    diff = A * P + D - Q;
    Norm = sqrt(sum(diff .^ 2));
    
    W = (Norm.^2 + delta) .^ (p/2 - 1); %big W = inlier
    W = W ./ max(W); %normalize W, between 0 and 1
    func(iter) = sum((Norm.^2 + delta) .^ (p/2));

    if abs(func(iter) - func(iter-1)) < epsilon
        figure(2);
        subplot(2, 1, 1);
        plot(func); %functiosn v. iterations, title
        subplot(2, 1, 2);
        hist(W);
        inliers = find(W > lowW);
        figure(3);
        DRAW(fn1, fn2, X(inliers), Y(inliers), X_(inliers), Y_(inliers), TXY(:, inliers), A);
        delta = delta * deltaFactor;
    end
    iter = iter + 1;
end
end