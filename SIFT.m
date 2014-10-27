function [ X, Y, X_, Y_ ] = SIFT( fn1, fn2 ) %density
%SIFT Scale Invariant Feature Transform
%   July 8-10, 2014

%read two images
im1 = imread(fn1);
im2 = imread(fn2);

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

%compute descriptors
%[x, y] = meshgrid([1:density:size(im1, 2),1:density:size(im1, 1)]);
% x_f = [];
% y_f = [];
% scale_f = [];
% scale = 2:2:8;
% for j = 1:length(scale)
%     x_f = [x_f x(:)];
%     y_f = [y_f y(:)];
%     scale_f = [scale_f, scale(j) * ones(numel(x))];
%end

[f1, d1] = vl_sift(copy1); %, 'Frames', [x_f, y_f, scale_f, ones(numel(x_f))]);
[f2, d2] = vl_sift(copy2);

%match images using vl_ubcmatch
i = vl_ubcmatch(d1, d2);

%find set of matching points
X = f1(1, i(1, :));
Y = f1(2, i(1, :));
X_ = f2(1, i(2, :));
Y_ = f2(2, i(2, :));

end