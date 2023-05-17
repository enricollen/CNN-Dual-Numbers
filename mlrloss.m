function [nll, g, od, percent] = mlrloss(wb, X, y, K, gpu, prediction)
if gpu == 1
    X = single(X); y = double(y);
end

% wb is expected to be of length (N+1)*(K-1)
% Hence, a concatenated weights and bias

% N features M examples
% K distinct classes (1 to K)
[N,M] = size(X);
theta = reshape(wb(1:N*(K-1)), K-1, N); %?
bias  = reshape(wb((1+N*(K-1)):end), K-1, 1); %?

% I indexes into the correct target entries 
% I matrice sparsa contenente lungo le colonne(immagine) vettori one-hot 
% con 1 sull'indice della classe a cui appartiene 
I=full(sparse(y,1:M,1,K,M));

% Compute the values after the linear transform
% bsxfn: @operazione da eseguire su ogni elemento, matrice su cui eseguire l'operazione, il terzo campo
% è il valore che va usato nell'operazione ; operazione eseguita su
% colonna(immagine)
W=[ bsxfun(@plus, theta * X, bias) ; zeros(1, M) ]; 

%lambda
%W = [W; zeros(1, M) ];

% This rescales so that all values are negative, hence, no overflow
% problems with the exp operation (a single +inf can blow things up)
% sottrae ad ogni valore della colonna il massimo tra i valori della colonna
W=bsxfun(@minus, W, max(W));  
W=exp(W);

% Convert to Probabilities by normalizing
% normalizza dividendo per la somma dei valori della colonna ogni elemento
% della colonna, e la somma dei valori su ogni colonna = 1 perchè 
% ha normalizzato e quindi corrisponde alle probabilità di appartenere alla classe i-esima  
P=bsxfun(@rdivide, W, sum(W));

% Loss.
% P(logical(I)) == I.*P which basically extracts out the terms we want
nll=-full(sum(log(P(logical(I))))); % loss function ceh produce uno scalare,
% "negative-log-likelihood" == cross-entropy loss function
if prediction == 1
    [~, indices] = max(P);
    percent = sum(y-indices== 0) / length(y);    
else
    percent = 0;
end
% Compute the gradients
if (nargout >= 2)
    od = (P - I); % P-I gives exactly the error derivatives at the "output units"
    % => explanation here: https://towardsdatascience.com/derivative-of-the-softmax-function-and-the-categorical-cross-entropy-loss-ffceefc081d1
    % after this theta' * od can be used as the backprop derivative
    % while od * X can be used as the derivative at the current layer
    gw = od * X'; % ????
    gw = gw(1:K-1,:); % leva l'ultimo gradiente perchè l'ha già calcolato a riga 53
    gb = sum(od, 2); %somma per righe
    gb = gb(1:K-1,:); % leva l'ultimo gradiente perchè l'ha già calcolato a riga 53
    g = [gw(:) ; gb(:)]; % gradiente di pesi + bias del layer 9
end

% Compute the derivatives for backprop
if (nargout >= 3)
    % use this for backprop
    od = theta' * od(1:K-1,:); % ????
end

end