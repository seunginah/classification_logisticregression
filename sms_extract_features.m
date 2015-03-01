function [ x ] = sms_extract_features( message, dict )
%EXTRACT_FEATURES Return feature vector for a given text message
%
% message  string containing a text message
% dict     the dictionary of words
%

words = sms_parse(message);
[~,ids] = ismember(words, dict);
ids = ids(ids > 0);
n = length(dict);
x = full(sparse(1, ids, 1, 1, n));
x = [1 x];

end

