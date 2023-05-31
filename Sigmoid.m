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
    %y = 1./(1+exp(-x));
    
    sz = size(x);
    y = reshape(x, [], 1);  % Reshape tensor to a column vector
    y = y./(abs(y) + 1) + 0.5;  % Apply sigmoid function element-wise
    y = reshape(y, sz);  % Reshape back to the original tensor size
    y = y.*0.5;  % Scale down the values
end