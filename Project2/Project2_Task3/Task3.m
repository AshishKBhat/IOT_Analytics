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
