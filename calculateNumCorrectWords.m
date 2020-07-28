% calculateNumCorrectWords.m
% Author: Kevin Chu
% Last Modified: 03/01/2020

function [numCorrect, correctlyGuessedWords] = calculateNumCorrectWords(response, correct)
    % This function counts the number of correct words in a subject's
    % response to a single sentence. Each word must exactly match a word in
    % the true sentence to be counted as correct.
    %
    % Args:
    %   -response (str): formatted subject response
    %   -correct (str): formatted correct sentence
    %
    % Returns:
    %   -numCorrect (double): number of correct words in subject's sentence
    %   -correctlyGuessedWords (cell): cell array of correctly guessed
    %   words

    % Parse words
    responseWords = strsplit(response, ' ');
    correctWords = strsplit(correct, ' ');
    
    % Preallocate cell array to hold correctly guessed words
    correctlyGuessedWords = cell(1,0);
    
    numCorrect = 0;
    % Iterate over correct words
    for i = 1:numel(correctWords)
        % Either multiple choices or single choice for correct word
        if ~isempty(strfind(correctWords{i}, '/'))
            curr_correct_words = strsplit(correctWords{i}, '/');
        else
            curr_correct_words{1} = correctWords{i};
        end
        
        % Find where correct word occurs in subject's response
        correct_word_locs = []; k = 1;
        for j = 1:numel(curr_correct_words)
            loc = find(strcmp(responseWords, curr_correct_words{j}), 1, 'first');
            if ~isempty(loc)
                correct_word_locs(k) = loc;
                k = k+1;
            end
        end
        
        % If correct word was found, add to number of correct words
        if ~isempty(correct_word_locs)
            correct_word_loc = min(correct_word_locs);
            correctlyGuessedWords = [correctlyGuessedWords responseWords(correct_word_loc)];
            responseWords(correct_word_loc) = []; % prevent double counting
            numCorrect = numCorrect + 1;
        end
        
        clear curr_correct_words
    end
    
end