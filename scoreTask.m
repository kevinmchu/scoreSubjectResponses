% scoreTask.m
% Author: Kevin Chu
% Last Modified: 03/01/2020

function taskInfo = scoreTask(taskList, sentenceStruct)
    % This function calculates the number of correct words as well as the
    % total number of words for a single task.
    %
    % Args:
    %   -taskList (sttTaskPregeneratedOpenSetSpeechForNormalHearing):
    %   contains task-related information including subject responses
    %   -sentenceTruth (cell array): contains correct answers to all
    %   sentences in the database
    %   -dictionary (struct): structure with words and the phonemes they
    %   are composed of
    %
    % Returns:
    %   -taskInfo (struct): structure with fields:
    %       -total_words (double): total number of words in all sentences
    %       presented to subjects in that condition
    %       -correct_words (double): number of correctly identified words
    %       -score (double): proportion of correct words
    %       * additional fields will exist for the conditions
    
    % Include condition information in taskInfo structure
    fields = fieldnames(taskList.stimulusTokens);
    fields = fields(~strcmp(fields, 'signal') & ~strcmp(fields, 'Fs'));
    for j = 1:numel(fields)
        taskInfo.(fields{j}) = taskList.stimulusTokens(1).(fields{j});
        if isempty(taskInfo.(fields{j}))
            taskInfo.(fields{j}) = NaN;
        end
    end

    % Accumulation variables
    taskInfo.performance.numCorrectWords = 0;
    taskInfo.performance.numWords = 0;
    taskInfo.performance.propCorrectWords = 0;
%     taskInfo.performance.numCorrectPhonemes = 0;
%     taskInfo.performance.numPhonemes = 0;
%     taskInfo.performance.propCorrectPhonemes = 0;
%     taskInfo.performance.phonemeStruct = getPhonemeStruct;

    filenames = extractfield(sentenceStruct,'filename');
    
    % Iterate over sentences and score separately
    for i = 1:numel(taskList.stimulusList)
        % Count the number of correct words in the subject's response
        responseWords = formatSentence(taskList.log.responses{i});
        correctStruct = sentenceStruct(cellfun(@(c)strcmp(c,taskList.stimulusList{i}),filenames));
        correctWords = formatSentence(correctStruct(1).sentence);
        currNumCorrectWords = calculateNumCorrectWords(responseWords, correctWords);
        
%         % Score phonemes
%         responsePhonemes = sttUtilConvertWordsToPhonemes(strsplit(lower(responseWords)), dictionary);
%         correctPhonemes = correctStruct(1).phonemes;
%         isPhonemeCorrect = analyzeCorrectPhonemes(responsePhonemes, correctPhonemes);
%         correctPhonemes = horzcat(correctPhonemes{:});
%         isPhonemeCorrect = horzcat(isPhonemeCorrect{:});
        
        % Accumulate the total # of correct words and total words
        taskInfo.performance.numWords = taskInfo.performance.numWords + numel(strsplit(correctWords));
        taskInfo.performance.numCorrectWords = taskInfo.performance.numCorrectWords + currNumCorrectWords;
        
%         taskInfo.performance.numPhonemes = taskInfo.performance.numPhonemes + numel(correctPhonemes);
%         taskInfo.performance.numCorrectPhonemes = taskInfo.performance.numCorrectPhonemes + sum(isPhonemeCorrect);
    end
    taskInfo.performance.propCorrectWords = taskInfo.performance.numCorrectWords/taskInfo.performance.numWords;
%     taskInfo.performance.propCorrectPhonemes = taskInfo.performance.numCorrectPhonemes/taskInfo.performance.numPhonemes;

end
