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

%%
%%Task2
%open the file
filename = 'BHAT_ASHISH_KRISHNA.CSV';
matrix = csvread(filename,1,0);
X1 = matrix(:,1);
X2 = matrix(:,2);
X3 = matrix(:,3);
X4 = matrix(:,4);
X5 = matrix(:,5);
Y = matrix(:,6);

%Let's start the linear model regression using fit for Y = a0 + a1X + ?, where X = X1.
linear_model = LinearModel.fit(X1,Y);
fprintf("the estimated coefficients are as displayed\n");
disp(linear_model)
a0=table2array(linear_model.Coefficients(1,1));
a1=table2array(linear_model.Coefficients(2,1));
variance = var(a0+a1*X1, 1);
fprintf("The value of a0, a1, and s2 is: %d %d %d\n",a0,a1,variance)

%task 2.2
rsquared = linear_model.Rsquared.Adjusted;
fprintf("The value of Rsquared is:%d\n",rsquared)
% As we can see the Rsquared value is 0.8 and hence approximately there is 80%
%variation in the data.
[p,F,d] = coefTest(linear_model);
fprintf("The value of p is:%d\n",p)
fprintf("The value of F is:%d\n",F)
% Since p values is < 0.05. Just by checking the p value The model fits the data very well.
%Task 2.3
h = figure;
plot(X1, a0+a1*X1);
hold on;
scatter(X1, Y);
hold off
title('regression_against_data');
xlabel('X values');
ylabel('Y values');
savefig(h, 'regressiondata.fig')
%Task 2.4a Q-Q plot.
q=figure;
%plotResiduals(linear_model)
%plotResiduals(linear_model,'fitted')
%plotResiduals(linear_model, 'probability')

qqplot(linear_model.Residuals.Raw);
savefig(q,"qq_plot.fig")

%2.4b Scatter Plot.
scatter(Y, linear_model.Residuals.Raw);
title("Scatter plot")
xlabel("Y values")
ylabel("residuals")
savefig(q,"scatter_residuals.fig")

% Task 2.7 Higher order polynomial regression:
higher_order_model=stepwiselm(X1,Y,'quadratic');




%%
%Task3

%Task 3.1:
%open the file
filename = 'BHAT_ASHISH_KRISHNA.CSV';
matrix = csvread(filename,1,0);
X1 = matrix(:,1);
X2 = matrix(:,2);
X3 = matrix(:,3);
X4 = matrix(:,4);
X5 = matrix(:,5);
Y = matrix(:,6);

%Let's start the multivariate model regression using fit.
all_variables = [X1 X2 X3 X4 X5];
multiple_linear_model = LinearModel.fit(all_variables,Y);
fprintf("the estimated coefficients are as displayed\n");
disp(multiple_linear_model)
a0=table2array(multiple_linear_model.Coefficients(1,1));
a1=table2array(multiple_linear_model.Coefficients(2,1));
a2=table2array(multiple_linear_model.Coefficients(3,1));
a3=table2array(multiple_linear_model.Coefficients(4,1));
a4=table2array(multiple_linear_model.Coefficients(5,1));
a5=table2array(multiple_linear_model.Coefficients(6,1));
variance_variable= a0+a1*X1+a2*X2+a3*X3+a4*X4+a5*X5;
variance = var(variance_variable, 1);
fprintf("The value of variance is: %d\n",variance)

%Task 3.2 after removing X2, X3 and Intercept
fprintf("The variable X2, X3 and intercept has been removed ===>\n")
modified_variables=[X1 X4 X5];
modified_multiple_model = LinearModel.fit(modified_variables,Y,'Intercept',false);
disp(modified_multiple_model)
[p,F,d] = coefTest(modified_multiple_model);
rsquared = linear_model.Rsquared.Adjusted;
fprintf("The value of Rsquared is:%d\n",rsquared)
fprintf("The value of p is:%d\n",p)
fprintf("The value of F is:%d\n",F)

a1=table2array(modified_multiple_model.Coefficients(1,1));
a4=table2array(modified_multiple_model.Coefficients(2,1));
a5=table2array(modified_multiple_model.Coefficients(3,1));
modified_variance_variable = a1*X1+a4*X4+a5*X5;
modified_variance = var(modified_variance_variable,1);
fprintf("The value of variance is: %d\n",variance)

%Task 3.4a Q-Q plot.
q=figure;
qqplot(modified_multiple_model.Residuals.Raw);
savefig(q,"qq_plot_multiple.fig")

%2.4b Scatter Plot.
scatter(Y, modified_multiple_model.Residuals.Raw);
title("Scatter plot")
ylabel("Y values")
xlabel("residuals")
savefig(q,"scatter_residuals_multiple.fig")

fprintf("The kai test value see is: %d \n",chi2gof(modified_multiple_model.Residuals.Raw))






