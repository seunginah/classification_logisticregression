% Preprocess the SMS Spam Collection data set
%  
%   https://archive.ics.uci.edu/ml/datasets/SMS+Spam+Collection
% 
% Dan Sheldon

rng(2);

numDocs = 5574;
numWords = 2000;
numTrain = 1000;
numTest  = 400;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open the file
fid = fopen('sms.txt');
if fid == -1
    error('Could not open file');
end

labels  = cell(numDocs,1);
doc_ids = cell(numDocs,1);
words   = cell(numDocs,1);

% Read each line
i = 1;
tline = fgets(fid);
while ischar(tline)    

    % First token is the label, remainder of line is the message
    [labels{i}, msg] = strtok(tline);
    words{i} = sms_parse(msg);    
    doc_ids{i} = repmat(i, length(words{i}), 1);
        
    tline = fgets(fid);    
    i = i+1;
end

doc_ids = vertcat(doc_ids{:});
words   = vertcat(words{:});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build dictionary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find unique words and their frequencies
[dict, ~, c] = unique(words);
freq = (hist(c,length(dict)))';

% Restrict to top 2500 words
[~,I] = sort(freq, 'descend');
top_words = I(1:numWords);
dict = dict(top_words);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create document-term matrix X and label vector y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~, word_ids] = ismember(words, dict);
I = word_ids > 0;
X = full(sparse(doc_ids(I), word_ids(I), 1, numDocs, numWords));
X = [ones(numDocs,1) X];
y = strcmp(labels, 'spam');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now massage and split into test/train
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Subsample positives to get class balance
pos = find(y==1);
neg = find(y==0);

npos = length(pos);

subset = [pos
          neg(1:length(pos))];

subset = subset(randperm(length(subset)));      
      
X = X(subset,:);
y = y(subset);

% Split 
train = 1:numTrain;
test  = numTrain + (1:numTest);

X_train = X(train,:);
y_train = y(train);

X_test  = X(test,:);
y_test  = y(test);

save sms.mat X_train y_train X_test y_test dict