rng('default');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear; clc;

data = csvread('book-data.csv');

% Data columns
%
% 1 - width
% 2 - thickness
% 3 - height
% 4 - pages
% 5 - hardcover
% 6 - weight

y = data(:,5);

% Extract the normalized features into named column vectors
width     = data(:,1);
thickness = data(:,2);
height    = data(:,3);
pages     = data(:,4);
weight    = data(:,6);

m = size(data,1);

% Create data matrix using only two features plus constant column
% data matrix
X = [ones(m,1) thickness height];
% get length
n = size(X,2);
% normalize data matrix
X = normalize_features(X);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fit the model and print out accuracy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

theta = zeros(n,1);  % debug your cost function: 
                     % the cost of this theta is 38.8162

debug_cost = sum(cost_function(X, y, theta));
debug_cost = debug_cost(1);
                     
% YOUR CODE HERE
%  1) call gradient descent to learn theta
alpha = 0.0001;
iters = 100;
[theta, costs] = gradient_descent(X, y, theta, alpha, iters);
size(theta)

%  2) plot J_history
%costs = sum(cost_function(X, y, theta));
costsdim = size(costs);
costsz = costsdim(2);
iterations = 1:costsz;

subplot (1, 2, 1);
plot(iterations, costs);
xlabel('Complexity');
ylabel('Cost');
title('Cost vs Complexity');

%  3) tune the step size and number of iterations if neeeded
%  4) print the accuracy---the percentage of correctly classified examples
%     in the training set

total_books = size(data(:,5), 1);
% define: predicted to be hardcover or paperback by logistic regression
predicted_hardcover = (logistic(theta'*X') >= 0.5)';
% how many books were correctly or incorrectly predicted to be hardcover?
crrct_hardcover = sum(y==1 & predicted_hardcover==1)
% how many books were correctly or incorrectly predicted to be paperbacks?
crrct_paperback = sum(y == 0 & predicted_hardcover ==0 )

percent_correct = ((crrct_hardcover + crrct_paperback) / total_books ) * 100

% Plot the logistic function and see if it looks like the one from class!
 subplot(1, 2, 2);
 z = -10:.1:10;
 p = logistic(z);
 %figure();
 plot(z, p);
 title('Logistic function')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualize the result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2); 
clf();
hold on;

% plot data (train and test)
pos = y==1;
neg = y==0;
scatter(X(pos,2), X(pos,3), '+');
scatter(X(neg,2), X(neg,3), 'o');

% plot the decision boundary
x1 = [min(X(:,2))-0.5 max(X(:,2))+0.5];
x2 = (theta(1) + theta(2)*x1)./(-theta(3));
line(x1, x2);

xlabel('thickness (normalized)');
ylabel('height (normalized)');

legend('Hardcover', 'Paperback', 'Decision boundary');
