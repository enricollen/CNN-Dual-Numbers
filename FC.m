% FC    Calculate linear transformation from input
%
%   y = FC(x, w, b) calculates linear transformation y given input x,
%       weight w, and bias b.
% 
%   Input:
%       x   = mx1 input to the fully connected layer
%       w   = nxm weight matrix
%       b   = nx1 bias
%
%	Output:
%       y   = nx1 output of the linear transformation

function y = FC(x, w, b)

    %y= w*x +b;
    
    [nRows, ~] = size(w);
    y = DualArray(zeros(nRows,1),zeros(nRows,1));
    
    for nR = 1:nRows
        y(nR).dArr = sum(times(x, w(nR, :)')) + b(nR);
    end

end