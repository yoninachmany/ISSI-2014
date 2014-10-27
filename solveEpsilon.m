function [ A, TXY, D ] = solveEpsilon( W, P, Q, yEpsilon )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here% x = [a b c Dx1 Dx2 ... d e f Dy1 Dy2 ...]
Px = P(1, :);
Py = P(2, :);
Qx = Q(1, :);
Qy = Q(2, :);

n = size(P, 2);

old_H_tilda = ...
    [sum(W .* Px .^ 2), sum(W .* Px .* Py), sum(W .* Px); ...
    sum(W .* Px .* Py), sum(W .* Py .^ 2), sum(W .* Py); ...
    sum(W .* Px), sum(W .* Py), sum(W)];

b = [ W .* Px; W .* Py; W]';

H_tilda = 2 * [old_H_tilda, b'; b, eye(n)];

H = [ H_tilda, zeros(n + 3); zeros(n + 3), H_tilda ];

f = -2 * [ ...
    sum(W .* Px .* Qx); ...
    sum(W .* Py .* Qx); ...
    sum(W .* Qx); ...
    (W .* Qx)';
    sum(W .* Px .* Qy); ...
    sum(W .* Py .* Qy); ...
    sum(W .* Qy); ...
    (W .* Qy)'];

options = optimset('LargeScale', 'off', 'Display', 'off');

AQuad = zeros(2*n + 6);
AQuad(4:n+3, 4:n+3) = eye(n);
AQuad(n+7:end, n+7:end) = eye(n);

BQuad = yEpsilon * ones(1, 2*n + 6);

abcdef = quadprog(H, f, AQuad, BQuad, [], [], [], [], [], options); %H is matrix, f is vector, 1/2 x'Hx + F'x = sum...
%abcdef = quadprog(H, f); %H is matrix, f is vector, 1/2 x'Hx + F'x = sum...
A = [abcdef(1:3)'; abcdef(n+4:n+6)'; 0 0 1];

TXY = A * [Px; Py; ones(1,n)];
D = [abcdef(4:n+3)'; abcdef(n+7:end)'; zeros(1, n)];
end