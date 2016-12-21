% Very simple and intuitive neural network implementation
%
%  Carl Löndahl, 2008
%  email: carl(dot)londahl(at)gmail(dot)com
%  Feel free to redistribute and/or to modify in any way
%  
%  Jacob Zelek, 2015 (updated for multiple hidden layers)
%  email: jacob(dot)zelek(at)gmail(dot)com
function [Output] = forwardprop(Input, W)
    w = size(W);
    HiddenLayers = w(2)-1;
    [samples,~] = size(Input);
    [features,~] = size(W(w(2)));
    Output = zeros(samples,features);

    % Add bias to inputs
    Input = [ones(samples,1) Input];
    
    for i = 1:samples
        I = Input(i,:)';
        layer = 1;
        output = f(W(layer)*I);
        disp(HiddenLayers);
        for k = 1:length(W)
            layer = layer + 1;
            output = f(W(layer)*[1; output]);
            disp(size(output));
        end
        Output(i,:) = output;
    end
end

function x = f(x)
    x = 1./(1+exp(-x));
end
