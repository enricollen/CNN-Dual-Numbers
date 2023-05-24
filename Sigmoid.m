% Sigmoid  Activate input using Sigmoid function
%
%   [y] = Sigmoid(x) activates the input x using Sigmoid and sets it to y.
%
%   Input:
%       x   = a general tensor, matrix or vector
%
%   Output:
%       y   = Sigmoid of x with same input size

function [y] = Sigmoid(x)
    y = 1./(1+exp(-x));
end