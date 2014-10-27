function [ ] = SIFT1( fn1, fn2, num_figure, thresh )
%SIFT1 first SIFT exercise, second on sheet
%   July 6 and 7, 2014

%run('D:\vlfeat-0.9.16\toolbox\vl_setup.m');

%read two images
im1 = imread(fn1);
im2 = imread(fn2);

figure(num_figure);
imshow([im1; im2]); hold on;

%only convert RGB images to gray
[~, ~, q1] = size(im1);
[~, ~, q2] = size(im2);

if q1 ~= 1
    image1 = rgb2gray(im1);
if q2 ~= 1
    image2 = rgb2gray(im2);
end

im1 = single(image1);
im2 = single(image2);

%show images on the same figure, side by side


%compute descriptors
[f1, d1] = vl_sift(im1);
[f2, d2] = vl_sift(im2);

%match images using vl_ubcmatch
%i1 = vl_ubcmatch(d1, d2);
%i2 = vl_ubcmatch(d2, d1);
%[~, c1] = intersect(i1(1,:), i2(2,:));
%i = i1(:,c1);

i = vl_ubcmatch(d1, d2, thresh);

%extract unique set (remove matching of one candidate to multiple
%and multiple candidates match to one)
%plot only the matches, use scatter command in order to visualize
%it clearly

m3 = size(i, 2);
cmap = colormap;
dotsize = ceil((f1(1, i(1, 1:m3))/size(im1, 2)) * 100);
color = ceil((f1(2, i(1, 1:m3))/size(im1, 1)) * 64);

scatter(f1(1, i(1, 1:m3)), f1(2, i(1, 1:m3)), dotsize, cmap(color,:), 'fill');
scatter(f2(1, i(2, 1:m3)), f2(2, i(2, 1:m3)) + size(image1, 1), dotsize, cmap(color,:), 'fill');

end