function [ ] = FullIRLSEpsilon( fn1, fn2, lowW, yEpsilon ) %0.5, 5
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
close all;
run('D:\vlfeat-0.9.16\toolbox\vl_setup.m');

[XSIFT, YSIFT, X_SIFT, Y_SIFT] = SIFT(fn1, fn2);
figure(1);
DRAW(fn1, fn2, XSIFT, YSIFT, X_SIFT, Y_SIFT, [], []);
IRLSEpsilon(fn1, fn2, XSIFT, YSIFT, X_SIFT, Y_SIFT, lowW, yEpsilon);

end