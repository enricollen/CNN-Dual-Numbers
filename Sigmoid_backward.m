% Sigmoid_backward     Compute loss derivative w.r.t the given input
%
%   Input:
%       dLdy    = loss derivative w.r.t output y
%       x       = input tensor, matrix, or vector
%
%   Output:
%       dLdx    = loss derivative w.r.t input x

function [dLdx] = Sigmoid_backward(dLdy, x)
   sigmoid_x = Sigmoid(x);

   sigmoid_derivative = sigmoid_x .* (1 - sigmoid_x); %14x14x3
   sigmoid_derivative = reshape(sigmoid_derivative, size(dLdy));
   dLdx = dLdy .* sigmoid_derivative;
end