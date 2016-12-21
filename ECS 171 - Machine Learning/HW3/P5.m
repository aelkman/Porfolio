function [acc, aucData] = P5()

    function [oMat] = binarize(iMat)
        oMat = zeros(126,size(iMat,1));
        for k = 1:size(iMat,1)
            oMat(iMat(k),k) = 1;
        end
    end

    df = xlsread('C:\Users\Alex\Documents\MATLAB\ECS171 HW3\ecs171.dataset.xlsx');        
    df = df(randperm(size(df,1)),:); %shuffle data for improved performance
    weights = load('p1_weights.mat');     %for use with p4
    weights = weights.w;
    weights = weights(:,19);
    
    indices = find(abs(weights)<0.0001);
    weights(indices) = [];     

    
%med and envrion pert for problem 5

    train_size = round(size(df,1)*9/10);
    test_size = round(size(df,1)/10);   

    strain = df(:,1);
    outputs(:,1) = strain;
    medium = df(:,2);
    outputs(:,2) = medium;
    stress = df(:,3);
    outputs(:,3) = stress;
    genepert = df(:,4);
    outputs(:,4) = genepert;
    
    count = 1;
    keyMap = containers.Map;
    for i = 1:max(medium)
        for j = 1:max(stress)
           name = ['m' num2str(i) 's' num2str(j)];
           keyMap(name) = count; 
           count = count+1;
        end
    end
    
    for i = 1:size(df,1)
        m = medium(i,1);
        s = stress(i,1);
        output(i,1) = keyMap(['m' num2str(m) 's' num2str(s)]);
    end
%         
%      df = df(:, 6:(size(df,2)));     %for use with p6
%     [COEFF,SCORE] = princomp(df');
%     df=SCORE(1:3,:)';
    
    df = df(:, 6:(size(df,2))); % for use with p4
    df(:, indices') = [];
    df = zscore(df);
    
%     for j = 1:4
%         
%         output = outputs(:,j);
       
        for i = 1:10


            train_x = df(1:(i-1)*test_size+1,:);
            train_y = output(1:(i-1)*test_size+1,:);
            train_x(test_size*(i-1)+1:train_size,:) = df((i*test_size)+1:size(df,1),:);
            train_y(test_size*(i-1)+1:train_size,:) = output((i*test_size)+1:size(df,1),:);
            test_x = df(test_size*(i-1)+1:test_size*i, :);
            test_y = output(test_size*(i-1)+1:test_size*i, :);
            
            model = svmtrain(train_y, train_x, ['-b 1']);
            [predicted_label, accuracy, vals_estimates] = svmpredict(test_y, test_x, model, ['-b 1']);
            
%            label_pred(:,i,j) = predicted_label;
             acc(:,i) = accuracy;
            %val_est(:, :, i, j) = vals_estimates;
            t_y = binarize(test_y);
            p_y = binarize(predicted_label);
            
            
            for j = 1:size(test_y,1)
                [X,Y,T,AUC] = perfcurve(p_y(:,j), vals_estimates(:,j), 1);
                aucData(j,i) = AUC;
            end    

        end
        %test_data(:,j) = test_y;
%         t_y = binarize(strain, medium, stress, genepert, test_y, j);
%         p_y = binarize(strain, medium, stress, genepert, predicted_label, j);  
%         if j == 1
%             strain_b(:,:,1) = t_y;
%             strain_b(:,:,2) = vals_estimates';
%         elseif j == 2
%             medium_b(:,:,1) = t_y;
%             medium_b(:,:,2) = vals_estimates';
%         elseif j == 3
%             stress_b(:,:,1) = t_y;
%             stress_b(:,:,2) = vals_estimates';
%         elseif j == 4
%             genepert_b(:,:,1) = t_y;
%             genepert_b(:,:,2) = vals_estimates';
%         end
        %test_data(:,:,j) = t_y;
        
        
        
%     end
%     
%     plotroc(strain_b(:,:,1), strain_b(:,:,2), 'strain'); 
%     print('StrainROC','-dpng');
%     plotroc(medium_b(:,:,1), medium_b(:,:,2), 'medium');
%     print('MediumROC','-dpng')
%     plotroc(stress_b(:,:,1), stress_b(:,:,2), 'stress');
%     print('StressROC','-dpng')
%     plotroc(genepert_b(:,:,1), genepert_b(:,:,2), 'genepert');
%     print('GenePertROC','-dpng')
%     prec_rec(strain_b(1,:,2), strain_b(1,:,1)); 
%     print('StrainPR','-dpng');    
%     prec_rec(medium_b(1,:,2), medium_b(1,:,1)); 
%     print('MediumPR','-dpng');    
%     prec_rec(stress_b(1,:,2), stress_b(1,:,1)); 
%     print('StressPR','-dpng');    
%     prec_rec(genepert_b(1,:,2), genepert_b(1,:,1)); 
%     print('GenePertPR','-dpng');


end