function [ ] = SIFT2( fn1, fn2 )
%SIFT2 second SIFT exercise, first on sheet
%   July 7 and 8, 2014
close all;

run('D:\vlfeat-0.9.16\toolbox\vl_setup.m');

%read and show any image
im1 = imread(fn1);
im2 = imread(fn2);

imshow(im1); hold on;

%only convert RGB images to gray
[~, ~, q1] = size(im1);
[~, ~, q2] = size(im2);

if q1 ~= 1
    copy1 = single(rgb2gray(im1));
else
    copy1 = single(im1); 
end

if q2 ~= 1
    copy2 = single(rgb2gray(im2));
else
    copy2 = single(im2); 
end

%compute the SIFT frames and descriptors (without sending the
%frames)
[f1, ~] = vl_sift(copy1);
[f2, ~] = vl_sift(copy2);

%select 100 random features (use randperm command)
%change the selection and plot again
for i = 1:2
    randIndices = randperm(length(f1));
    figure(i); imshow(im1); hold on;
    if i == 1
        vl_plotframe(f1(:, randIndices(1:100)))
    else
        vl_plotframe(f2(:, randIndices(1:100)))
    end
    
    %can't plot descriptor bc [-6,6,-6,6]
    %vl_plotsiftdescriptor(d(:, randIndices(1:100)))
end

%determine beforehand the frames and repeat the process
%repeat this process for a different image
for i = 3:4
    if i == 3
        [x, y] = meshgrid([1:density:size(im1, 2),1:density:size(im1, 1)]);
        figure(i);
        imshow(im1);
        [f, ~] = vl_sift(copy1, 'Frames', [x(:)'; y(:)'; 2*ones(1, numel(x)); ones(1, numel(x))]);
    else
        [x, y] = meshgrid([1:density:size(im2, 2),1:density:size(im2, 1)]);
        figure(i);
        imshow(im2);
        [f, ~] = vl_sift(copy2, 'Frames', [x(:)'; y(:)'; 2*ones(1, numel(x)); ones(1, numel(x))]);
    end
    
    hold on;
    %randIndices = randperm(length(f));
    vl_plotframe(f);%randIndices(1:100)));
end

%try to understand the figures (don't try to understand any
%feature but try to see the general idea)
end