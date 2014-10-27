function [ ] = SIFT1Tester( fn1, fn2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

run('D:\vlfeat-0.9.16\toolbox\vl_setup.m');

close all;
thresh = 0.5:0.5:2.5;
for i = 1:length(thresh)
    SIFT1(fn1, fn2, i, thresh(i));
end

end