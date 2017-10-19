%%Task1
%open the file
filename = 'BHAT_ASHISH_KRISHNA.CSV';
matrix = csvread(filename,1,0);
X1 = matrix(:,1);
X2 = matrix(:,2);
X3 = matrix(:,3);
X4 = matrix(:,4);
X5 = matrix(:,5);
Y = matrix(:,6);

for i = 1:6
    if i == 6
        name = 'histogram_Y.fig';
        title_name = 'histogram_Y.fig';
    else
        name = strcat('histogram_X',int2str(i),'.fig');
        title_name = strcat('histogram_X',int2str(i),'.fig');
    end
    h= figure;  
    histogram(matrix(:,i));
    title(title_name);
    xlabel('Data value');
    ylabel('Frequency');
    savefig(h,name)
end  

mean_values  = mean(matrix);
variance_values = var(matrix,1);

for i = 1:6
    if i == 6
        fprintf('The mean and variance of Y are %f %f\n',mean_values(i), variance_values(i))
        
    else
        fprintf('The mean and variance of X%i is %f %f \n', i,mean_values(i),variance_values(i))
    end   
end
%Task 1.2
% box plot

for i = 1:6
    if i == 6
        name = 'BOX_PLOT_Y.fig';
        title_name = 'BOX_PLOT_Y.fig';
    else
        name = strcat('BOX_PLOT_X',int2str(i),'.fig');
        title_name = strcat('BOX_PLOT_X',int2str(i),'.fig');
    end
    h= figure;  
    boxplot(matrix(:,i));
    title(title_name);
    xlabel(strcat('X',int2str(i)));
    ylabel('Values');
    savefig(h,name)
end  


%Task 1.3
% correlation matrix
correlation_matrix = corrcoef(matrix);
fprintf("The correlation matrix is as shown below \n")
disp(correlation_matrix)

% As we can see from the correlation matrix, there is a strong
% positive correlation between X1 and Y.
% X1 and X2 are negatively correlated.