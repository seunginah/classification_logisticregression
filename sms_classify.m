%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load sms.mat;  % loads the following variables

% X_train  contains information about the words within the training
%          messages. the ith row represents the ith training message. 
%          for a particular text, the entry in the jth column tells
%          you how many times the jth dictionary word appears in 
%          that message
%
% X_test   similar but for test set
%
% y_train  ith entry indicates whether message i is spam
%
% y_test   similar
%
% dict     Cell array whose jth entry is the jth dictionary word

[m, n] = size(X_train);
%X_train([1],:)

%X_fst = X_train([1],:);
%X_normalize = normalize_features(X_train([2:3],:));
X_train = normalize_features(X_train);

% Initialize theta
theta_init = zeros(n,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Train
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% YOUR CODE HERE: 
%  - learn theta by gradient descent 
alpha = 0.00001;
iters = 100;
[theta, J_history] = gradient_descent(X_train, y_train, theta_init, alpha, iters);

%  - plot the cost history
costsz = size(J_history, 2);
complexity = 1:costsz;

subplot (1, 1, 1);
plot(complexity, J_history);
xlabel('Complexity');
ylabel('Cost');
title('Cost vs Complexity');
%  - tune step size and # iterations if necessary


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Testing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% YOUR CODE HERE
%  - use theta to make predictions for test set
z = theta' * X_test';
y = logistic(z);

%  - print the accuracy on the test set---i.e., the precent of messages misclassified
total_msgs = size(X_test,1);

% define: if predicted to be spam by logistic regression, y = 1
predicted_spam = (logistic(z) >= 0.5)'
% how many msgs were correctly predicted as spam?
crrct_spam = sum(y_test==1 & predicted_spam==1)
% how many msgs were correctly predicted as ham?
crrct_ham = sum(y_test == 0 & predicted_spam ==0 )

percent_crrct = ((crrct_spam +crrct_ham)/total_msgs)*100

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inspect the model to see which words are indicative of spam and non-spam
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

word_weights = theta(2:end); 
[~,I] = sort(word_weights, 'descend');
[~,J] = sort(word_weights, 'ascend');

k = 10;

fprintf('Top %d spam words\n', k);
fprintf('  %s\n', dict{I(1:k)});
fprintf('\n');
fprintf('Top %d nonspam words\n', k);
fprintf('  %s\n', dict{J(1:k)});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predict for your own message
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

text = 'Please join our very own alum Ashely DeFlumere 09 on Friday, October 17th from 10:00 a.m. to 11:00 a.m. in Kendade 307. Title: Scientific Computing in a new world: Algorithms and models for optimal performance on heterogeneous systems. Abstract: The computational resources available to researchers in the physical and life sciences have grown immensely in this era of petaflop computing. Increasingly, these resources are heterogeneous in nature, incorporating GPUs, and other hardware accelerators and coprocessors. But how does this change in architecture effect the algorithms and models used in scientific computing? For a given scientific application, how do we determine if a particular algorithm, or decomposition of data or tasks is optimal? We focus on a common underlying computation in many scientific fields; matrix multiplication. We discuss how to derive mathematical models of both efficient matrix multiplication algorithms, and common heterogeneous systems. Using these models, the optimal distribution of amongst heterogeneous processors for matrix multiply, an NP-complete problem, is rethought using a new technique. There will also be time to speak with Ashely after the talk about her Grad School experience. Wendy D. Queiros Computer Science Department';
text2 = 'Hello to you I am sweet and romantic girl. I believe in miracles. I try to live my life to the fullest. I like spending time outdoors and with friends. I have various interests and reading is one of them http://goo.gl/UUaE7B I want to find a man who is serious about having family and who has good sense of humor. Contact me';
x_my_ham = sms_extract_features(text, dict);
x_my_spam = sms_extract_features(text2, dict);
y_my_ham = logistic(theta'*x_my_ham');
y_my_spam = logistic(theta'*x_my_spam')

if y_my_ham >=0.5
    fprintf('i think your ham is spam\n')
else
    fprintf('i think your ham is ham\n')
end

if y_my_spam >=0.5
    fprintf('i think your spam is spam\n')
else
    fprintf('i think your spam is ham\n')
end

% YOUR CODE HERE
%  - try a few texts of your own
%  - predict whether they are spam or non-spam




