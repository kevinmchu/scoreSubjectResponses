% scoreTask.m
% Author: Kevin Chu
% Last Modified: 08/11/2020

function taskInfo = scoreTask(taskList, sentenceStruct, dictionary, scorePhonemes)
    % This function calculates the number of correct words as well as the
    % total number of words for a single task.
    %
    % Args:
    %   -taskList (sttTaskPregeneratedOpenSetSpeechForNormalHearing):
    %   contains task-related information including subject responses
    %   -sentenceStruct ():
    %   -scorePhonemes (boolean): whether to score phonemes in addition to
    %   words
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
    
    if scorePhonemes
        taskInfo.performance.numCorrectPhonemes = 0;
        taskInfo.performance.numPhonemes = 0;
        taskInfo.performance.propCorrectPhonemes = 0;
        taskInfo.performance.phonemeStruct = getPhonemeStruct;
    end

    filenames = extractfield(sentenceStruct,'filename');
    
    % Iterate over sentences and score separately
    for i = 1:numel(taskList.stimulusList)
        % Count the number of correct words in the subject's response
        responseWords = formatSentence(taskList.log.responses{i});
        trueStruct = sentenceStruct(cellfun(@(c)strcmp(c,strrep(taskList.stimulusList{i}, '.wav', '')),filenames));
        trueWords = formatSentence(trueStruct(1).sentence);
        currNumCorrectWords = calculateNumCorrectWords(responseWords, trueWords);
        
        % Accumulate the total # of correct words and total words
        taskInfo.performance.numWords = taskInfo.performance.numWords + numel(strsplit(trueWords));
        taskInfo.performance.numCorrectWords = taskInfo.performance.numCorrectWords + currNumCorrectWords;
        
        % Score phonemes
        if scorePhonemes
            % Get cell array of true phonemes
            truePhonemes = trueStruct(1).phonemes;
            
            % Convert words to phonemes if response is non-empty (i.e. not
            % "I don't know"). If response is empty (i.e. "I don't know"),
            % then there are no correct phonemes
            if ~isempty(responseWords)
                responsePhonemes = sttUtilConvertWordsToPhonemes(strsplit(lower(responseWords)), dictionary);
                isPhonemeCorrect = analyzeCorrectPhonemes(responsePhonemes, truePhonemes);
                truePhonemes = horzcat(truePhonemes{:});
                isPhonemeCorrect = horzcat(isPhonemeCorrect{:});
            else
                truePhonemes = horzcat(truePhonemes{:});
                isPhonemeCorrect = zeros(1, numel(truePhonemes));
            end
            
            % Accumulate total # of correct phonemes and total phonemes
            taskInfo.performance.numPhonemes = taskInfo.performance.numPhonemes + numel(truePhonemes);
            taskInfo.performance.numCorrectPhonemes = taskInfo.performance.numCorrectPhonemes + sum(isPhonemeCorrect);
            
            % Score phoneme by phoneme basis
            for j = 1:numel(truePhonemes)
                idx = cell2mat(cellfun(@(c)isequal(c, truePhonemes{j}), extractfield(taskInfo.performance.phonemeStruct,'phoneme'), 'UniformOutput', false));
                taskInfo.performance.phonemeStruct(idx).correct = taskInfo.performance.phonemeStruct(idx).correct + isPhonemeCorrect(j);
                taskInfo.performance.phonemeStruct(idx).total = taskInfo.performance.phonemeStruct(idx).total + 1;
            end
        end

    end
    taskInfo.performance.propCorrectWords = taskInfo.performance.numCorrectWords/taskInfo.performance.numWords;
    
    if scorePhonemes
        taskInfo.performance.propCorrectPhonemes = taskInfo.performance.numCorrectPhonemes/taskInfo.performance.numPhonemes;
    end

end
