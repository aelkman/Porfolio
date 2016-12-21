% Very simple and intuitive neural network implementation
%
%  Carl Löndahl, 2008
%  email: carl(dot)londahl(at)gmail(dot)com
%  Feel free to redistribute and/or to modify in any way
%  
%  Jacob Zelek, 2015 (updated for multiple hidden layers)
%  email: jacob(dot)zelek(at)gmail(dot)com

function [W, err] = backprop(Input, Output, HiddenLayers, HiddenNodes, Iterations, LearnRate)

[Samples,Features] = size(Input);
[~,Classes] = size(Output);

% Add bias to inputs
Input = [ones(Samples,1) Input];

% Initialize matrices with random weights 0-1

% First hidden layer
layer = 1;
W{layer} = rand(HiddenNodes, Features+1);

% All other hidden layers
for k = 1:HiddenLayers-1
    layer = layer + 1;
    W{layer} = rand(HiddenNodes,HiddenNodes+1);
end

% Output layer
layer = layer + 1;
W{layer} = rand(Classes,HiddenNodes+1);

m = 0; e = size(Input);

while m < Iterations

    % Increment loop counter
    m = m + 1;

    % Iterate through all examples
    for i=1:e(1)
        
        % Input data from current example set
        I = Input(i,:).';
        D = Output(i,:).';

        % Propagate the signals through network
        layer = 1;
        V{layer} = f(W{layer}*I);
        
        for k = 1:HiddenLayers
            layer = layer + 1;
            V{layer} = f(W{layer}*[1; V{layer-1}]);
        end

        % Output layer error
        delta{layer} = V{layer}.*(1-V{layer}).*(D-V{layer});
        
        % Calculate error for each node in layer_(n-1)
        for k = 1:HiddenLayers
            layer = layer - 1;
            delta{layer} = V{layer}.*(1-V{layer}).*(W{layer+1}(:,2:end).'*delta{layer+1});
        end 
        
        % Adjust weights in matrices sequentially
        layer = HiddenLayers + 1;
        for k = 1:HiddenLayers
            W{layer} = W{layer} + LearnRate.*delta{layer}*([1; V{layer-1}].');
            layer = layer - 1;
        end
        
        W{1} = W{1} + LearnRate.*delta{1}*(I.');
    end
    
    RMS_Err = 0;

    % Calculate RMS error
    for i=1:e(1)
        D = Output(i,:).';
        I = Input(i,:).';
        
        layer = 1;
        output = f(W{layer}*I);
        for k = 1:HiddenLayers
            layer = layer + 1;
            output = f(W{layer}*[1; output]);
        end
        
        RMS_Err = RMS_Err + norm(D-output,2);
    end
    
    err = RMS_Err/e(1);
end
end

function x = f(x)
    x = 1./(1+exp(-x));
end