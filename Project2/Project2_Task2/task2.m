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

