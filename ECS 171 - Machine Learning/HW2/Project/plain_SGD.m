clear all
close all
clc
% this demo shows a standard SGD for a binary classification problem with
% zebra stripe like pattern 
batch_size = 100;
W1 = randn(100, 2+1)/sqrt(2+1); % neural network coefficients
W2 = randn(1, size(W1,1)+1)/sqrt(size(W1,1)+1);
max_iter = 1e6;
cost0 = zeros(1, max_iter);
for iter = 1 : max_iter
    grad_W1 = zeros(size(W1));  % gradients
    grad_W2 = zeros(size(W2));    
    for i = 1 : batch_size
        u = rand(2, 1); % raw features
        v = sqrt(12)*(u - [0.5;0.5]);   % normalized features
        class_label = mod(round(10^u(1) - 10^u(2)), 2);
        class_label = 2*class_label - 1;
        
        x1 = tanh( W1*[v; 1] );
        y = W2*[x1;1];
        e = log( 1 + exp(-class_label*y) ); % logistic loss
        cost0(iter) = cost0(iter) + e;
        J = -class_label/(1+exp(class_label*y));
        grad_W2 = grad_W2 + J*[x1; 1]';
        J = (1-x1.*x1).*(W2(:,1:end-1)'*J);
        grad_W1 = grad_W1 + J*[v; 1]';
    end
    cost0(iter) = cost0(iter) / batch_size;
    
    grad_W1 = grad_W1/batch_size;
    grad_W2 = grad_W2/batch_size;
    
    W1 = W1 - 0.1*grad_W1;    % SGD; iteration is fast, but it is very tough to tune SGD to achieve a reasonably good performance 
    W2 = W2 - 0.1*grad_W2;
    
    if mod(iter, 100) == 0
        fprintf('Iteration %g; loss %g \n', iter, mean(cost0(iter-99:iter)));
    end
end
plot(cost0)