% combineScoresRepeatedTasks.m
% Author: Kevin Chu
% Last Modified: 02/26/2020

function allTaskInfoNew = combineScoresRepeatedTasks(allTaskInfo)
    % This function combines the scores from repeated tasks
    %
    % Args:
    %   allTaskInfo (struct): struct array containing (possibly repeated)
    %   task conditions and number of correct words
    %
    % Returns:
    %   allTaskInfoNew (struct): updated struct
    
    fields = fieldnames(allTaskInfo);
    conditions = fields(~strcmp(fields, 'performance'));
    
    % Create structure to hold combined scores for repeated tasks
    allTaskInfoNew = struct;
    for i = 1:numel(fields)
        allTaskInfoNew.(fields{i}) = [];
    end
    
    % Find the repeated tasks
    for i = 1:numel(allTaskInfo)
        currConditionCell = cellfun(@(c)allTaskInfoNew(end).(c),conditions,'UniformOutput',false);
        newConditionCell = cellfun(@(c)allTaskInfo(i).(c),conditions,'UniformOutput',false);
        
        % If condition is not already in allTaskInfoNew, create new row
        if ~isequaln(newConditionCell, currConditionCell)
            allTaskInfoNew = [allTaskInfoNew; allTaskInfo(i)];
        
        % If condition does exist, add up the scores
        else
            % Words
            allTaskInfoNew(end).performance.numCorrectWords = allTaskInfoNew(end).performance.numCorrectWords + allTaskInfo(i).performance.numCorrectWords;
            allTaskInfoNew(end).performance.numWords = allTaskInfoNew(end).performance.numWords + allTaskInfo(i).performance.numWords;
            allTaskInfoNew(end).performance.propCorrectWords = allTaskInfoNew(end).performance.numCorrectWords/allTaskInfoNew(end).performance.numWords;
            
            % Phonemes
            if isfield(allTaskInfoNew(end).performance, 'numPhonemes')
                allTaskInfoNew(end).performance.numCorrectPhonemes = allTaskInfoNew(end).performance.numCorrectPhonemes + allTaskInfo(i).performance.numCorrectPhonemes;
                allTaskInfoNew(end).performance.numPhonemes = allTaskInfoNew(end).performance.numPhonemes + allTaskInfo(i).performance.numPhonemes;
                allTaskInfoNew(end).performance.propCorrectPhonemes = allTaskInfoNew(end).performance.numCorrectPhonemes/allTaskInfoNew(end).performance.numPhonemes;
            end
        end
    end
    
    % Delete empty row
    allTaskInfoNew(1) = [];

end