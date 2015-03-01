function [ p ] = logistic( z )
%LOGISTIC The logistic function
% 
% IMPORTANT: If z is a vector or matrix, your code should return a vector
% or matrix of the same size (use elementwise operations)

% Write code to properly compute the logistic function
% p = 0.5;

% fill and return a vector with answers
p = [];
% e
e= exp(1);
% logistic function
p = 1./(1+e.^(-z));

end
