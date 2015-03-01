function [ cost ] = cost_function( X, y, theta )
%COST_FUNCTION Compute the cost function for a particular data set and
%              hypothesis (weight vector)
%
% Inputs: X      m x n data matrix
%         y      m x 1 vector of training outputs
%         theta  n x 1 vector of weights
%

% Write code to compute the cost
z = theta' * X';
p = logistic(z);

% p^(i) = hypothesis_theta(x^(i))
% if cost p (+) = -log(p)  --> y = 1
% if cost p (-) = log(1-p) --> y = 0
y_0 = -y*log(p);
y_1 = (1-y)*log(p);

cost = y_0 - y_1;

end
