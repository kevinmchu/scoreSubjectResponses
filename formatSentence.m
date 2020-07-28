% formatSentence.m
% Author: Kevin Chu
% Last Modified: 03/01/2020

function formatted_sentence = formatSentence(sentence)
    % Cleans up sentence string before scoring. Specifically, this function
    % makes all the letters uppercase and removes punctuation.
    %
    % Args:
    %   -sentence (str): either the subject's response or correct sentence
    %
    % Returns:
    %   -formatted_sentence (str)

    % Make uppercase
    temp = upper(sentence);
    
    % Return blank string if sentence is "I don't know" (has to match 
    % exactly)
    if strcmp(sentence, 'I DON''T KNOW')
        formatted_sentence = '';
        return
    end
    
    % Strips all punctuation except for ' / and spaces
    words = strsplit(temp, '[^a-zA-Z0-9''\/ ]', 'DelimiterType', 'RegularExpression');
    temp = strjoin(words);
    temp = strtrim(temp);
    temp = regexprep(temp, ' +', ' ');
    
    % Convert Arabic numerals into spelled out numbers
    if ~isempty(regexp(temp, '\d'))
        words = strsplit(temp, ' ');
        for i = 1:numel(words)
            if ~isnan(str2double(words{i}))
                words{i} = upper(num2words(str2double(words{i})));
            end
        end
        formatted_sentence = strjoin(words);
    else
        formatted_sentence = temp;
    end
    
end