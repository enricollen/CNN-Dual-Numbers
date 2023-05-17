function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    
    c_matrix = zeros([h_out,w_out,c]);
    r_out = zeros(1, w_out); 
    for b = 1:batch_size
        % riporta in forma matriciale 24x24 le 20 convoluzioni
        % dell'immagine nella colonna b-esima
        im = reshape(input.data(:, b), [h_in, w_in, c]);
        im = padarray(im, [pad, pad], 0);
        %per ogni kernel
        for ch = 1:c
            i = 1;
            % per h da 1 a 24 con passo(stride) 2
            for h = 1: stride: (2*pad) + h_in
               j = 1;
               % per w da 1 a 24 con passo(stride) 2
               for w = 1: stride : (2*pad) + w_in
                    %max pooling. k = dim del filtro di pooling
                    %sta prendendo il massimo su una finestra 2x2 dalla
                    %matrice ch-esima
                    r_out(j) = max(im(h: h+k-1, w: w+k-1, ch),[], 'all');
                    % j serve per popolare tutta la riga della matrice
                    % risultate c_matrix. quindi calcola il max-pooling
                    % riga per riga (1x12) alla volta
                    j = j + 1;
               end
               c_matrix(i, :, ch) = r_out;
               i = i + 1;
            end
        end
        %rimette lungo una colonna la max-pooling di tutte le convoluzioni relative a una immagine
        output.data(:, b) = reshape(c_matrix, [], h_out*w_out*c);    
    end
end

