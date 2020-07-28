% analyzeCorrectPhonemes.m
% Author: Kevin Chu
% Last Modified: 03/03/2020

function isPhonemeCorrect = analyzeCorrectPhonemes(responsePhonemes, correctPhonemes)
    % Args:
    %   -responsePhonemes (cell array): cell array where each cell is a
    %   word, which is in turn represented by a cell array of phonemes
    %   -correctPhonemes (cell array): the true list of phonemes
    %
    % Returns:
    %   -isPhonemeCorrect (cell array): cell array that specifies whether a
    %   phoneme was correctly identified
    %
    % Based on KSP code

    % Find match between response words and correct words. A match is found
    % for a response/correct word pair with the highest number of matched
    % phonemes
    [matchedResponseWordsI, matchedCorrectWordsI] = sttUtilMatchWords(correctPhonemes, responsePhonemes);
    responsePhonemes = responsePhonemes(matchedResponseWordsI);
    correctPhonemesSubset = correctPhonemes(matchedCorrectWordsI);
    isPhonemeCorrect = cell(size(correctPhonemes));
    
    % Start with cell array of zeros
    for w = 1:numel(correctPhonemes)
        isPhonemeCorrect{w} = zeros(size(correctPhonemes{w}));
    end
    
    for w = 1:numel(correctPhonemesSubset)
        for p = 1:numel(responsePhonemes{w})
            phonemeMatch = find(strcmp(responsePhonemes{w}{p}, correctPhonemesSubset{w}), 1, 'first');
            if ~isempty(phonemeMatch)
                isPhonemeCorrect{matchedCorrectWordsI(w)}(phonemeMatch) = 1;
                correctPhonemesSubset{w}{phonemeMatch} = [];
            end
        end
    end

end