function [ ] = DRAW( fn1, fn2, X, Y, X_, Y_, TXY, bestT) 
%DRAW P, Q, distance from Q to TP, edge of image
%   Detailed explanation goes here
im1 = imread(fn1);
im2 = imread(fn2);

cmap = colormap;

imshow([im1, im2]); hold on;

im1len = size(im1, 1);
im1width = size(im1, 2);

%draw P and Q, size increasing on x, color increasing on y

dotsize = ceil(Y/im1len * 100);
color = ceil(X/im1width * 64);

scatter(X, Y, dotsize, cmap(color, :), 'fill');
scatter(X_ + im1width, Y_, dotsize, cmap(color, :), 'fill');

if ~isempty(TXY)
    %draw line from Q to TP
    for i = 1: length(X_)
        plot([X_(i) + im1width, TXY(1, i) + im1width], [Y_(i), TXY(2, i)], 'LineWidth', 3, 'Color', 'k');
    end
end

%draw edges of P
% if ~isempty(bestT)
%     corners = [1,1; 1,im1len; im1width, im1len; im1width,1];
%     scatter(corners(:, 1), corners(:, 2), [], 'y', 'fill');
%     for i = 1:3
%         plot(corners(i:i+1, 1), corners(i:i+1, 2), 'LineWidth', 3, 'Color', 'y');
%     end
% 
%     plot(corners([4,1], 1), corners([4,1], 2), 'LineWidth', 3, 'Color', 'y');
% 
%     %draw edges of Q
%     newCorners = (bestT * [corners'; ones(1, 4)])';
%     newCorners(:, 1) = newCorners(:, 1) + im1width;
%     scatter(newCorners(:, 1), newCorners(:, 2), [], 'm', 'fill');
%     for i = 1:3
%         plot(newCorners(i:i+1, 1), newCorners(i:i+1, 2), 'LineWidth', 3, 'Color', 'm');
%     end
% 
%     plot(newCorners([4,1], 1), newCorners([4,1], 2), 'LineWidth', 3, 'Color', 'm');
% end