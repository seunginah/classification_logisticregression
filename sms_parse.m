function [ words ] = sms_parse( msg )
%SMS_PARSE Parse an sms message and return a cell array of words
%
% Input:
%   msg     string containing sms message
% Output 
%   words   cell array of words in message 
%
% The procedure eliminates punctuation, converts to lowercase, and creates
% special tokens for monetary symbols (dollar sign or pounds sterling) and 
% the URL divider '://'

% convert GBP symbol to dollar sign and add a space
msg = regexprep(msg,'[£$]',' $ ');

% convert :// to special token
msg = regexprep(msg, '\://', ' __url__ ');

% convert non-alaphnumeric to space
msg = lower(regexprep(msg,'[^_\s$a-zA-Z0-9]',' '));

% split into words
C = textscan(msg, '%s');
words = C{1};

end
