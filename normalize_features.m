function [ X, mu, sigma ] = normalize_features( X, mu, sigma )
%NORMALIZE_FEATURES Normalize the features
%
% The typical usage is:
%
%  [X_train, mu, sigma] = normalize_features(X_train);
%  X_test = normalize_features(X_test, mu, sigma)
%
% The first function call computes mu and sigma from the training data and
% normalizes the training data. The second call uses mu and sigma from the
% training data to normalize the test data. 

% If mu and sigma and not provided compute them
if nargin < 2
    mu = mean(X);
    sigma = std(X);
end

% If sigma = 0 set it to 1
sigma(sigma==0)=1;

for j=1:size(X,2)
    X(:,j) = (X(:,j) - mu(j))/sigma(j);
end

end
