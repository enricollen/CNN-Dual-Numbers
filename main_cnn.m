function main_cnn

load('mnist_train.mat');
load('mnist_test.mat');

% Data preprocessing
rng(1);
batch_size = 1; %30
im_train = im_train/255;
im_test = im_test/255;
im_test = im_test(:, 1:10);
[mini_batch_x, mini_batch_y] = GetMiniBatch(im_train, label_train, batch_size);

% input->conv->relu->pool->flat->fc(10)->softmax->cross_entropy
% conv filter: 3x3x1x3
load('w_conv_and_w_fc.mat');
[w_conv, b_conv, w_fc, b_fc] = TrainCNN(mini_batch_x, mini_batch_y, w_conv, w_fc);


% Test
%acc = 0;
%confusion = zeros(10,10);
%for iTest = 1 : size(im_test,2)
%    x = reshape(im_test(:,iTest), [14, 14, 1]);
%    pred1 = Conv(x, w_conv, b_conv); 
%    pred1 = DualTensor(pred1, ones(size(pred1)));
%    pred2 = Sigmoid(pred1);
%    pred2 = getReal(pred2);
%    pred3 = Pool2x2(pred2);
%    pred4 = Flattening(pred3);
%    pred5 = FC(pred4, w_fc, b_fc);
%    y = SoftMax(pred5);
%    
%    [~,l] = max(y);
%    confusion(label_test(iTest)+1, l) = confusion(label_test(iTest)+1, l) + 1;
%    
%    if l == label_test(iTest)+1
%        acc = acc + 1;
%    end    
%end
%accuracy = acc / size(im_test,2);
%for i = 1 : size(confusion,1)
%    confusion(i,:) = confusion(i,:)/sum(confusion(i,:));
%end

%categories = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

%fig_handle = figure(1);
%clf;
%imagesc(confusion, [0, 1]);
%set(fig_handle, 'Color', [.988, .988, .988])
%axis_handle = get(fig_handle, 'CurrentAxes');
%set(axis_handle, 'XTick', 1:10)
%set(axis_handle, 'XTickLabel', categories)
%set(axis_handle, 'YTick', 1:10)
%set(axis_handle, 'YTickLabel', categories)
%xlabel(sprintf('Accuracy: %f', accuracy));
%save('./Outputs/cnn.mat', 'w_conv', 'b_conv', 'w_fc', 'b_fc');
