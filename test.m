A = [1 2 3 4; 5 6 7 8; 8 7 6 5; 4 3 2 1];
w = [1 2 3 ; 4 5 6; 7 8 9];
b = 0;
pad = 1;
stride = 1;
%[h , w] = size(A);

%r_pad = zeros(h,1) ; c_pad = zeros(1,w+2);

%A_padded = [c_pad; [r_pad A r_pad]; c_pad];


%y = Conv(A, w, b);

% Compute the size of input matrix and kernel
[m, n] = size(A);
[k, ~] = size(w);

% Compute the size of the output matrix
output_size = floor((m + 2 * pad - k) / stride) + 1;

% Add padding to the input matrix
A_pad = padarray(A, [pad, pad]);

% Initialize the output matrix
output = zeros(output_size);

% Perform convolution operation
for i = 1:output_size
    for j = 1:output_size
        % Extract the patch from padded input matrix
        patch = A_pad(i:i+k-1, j:j+k-1);
        
        % Compute the convolution operation with bias
        output(i, j) = sum(sum(patch .* w)) + b;
    end
end

% Display the output matrix
disp(output);