% scoreSubjectResponses.m
% Author: Kevin Chu
% Last Modified: 08/19/2020

function scoreSubjectResponses(subject, inDir, outDir, inFile, isSorted, scorePhonemes, excludedTasks, truthFile, dictFile)
    % This function extracts a subject's responses from their .mat file and 
    % calculates their score for each task.
    %
    % Args:
    %   -subject (str): name of subject's folder
    %   -inDir (str): directory containing data for current study
    %   -outDir (str): directory where scores will be saved
    %   -isSorted (boolean): whether to sort scores by condition (true) or
    %   chronological order (false)
    %   -scorePhonemes (boolean): whether to score phonemes in addition to
    %   words
    %   -excludedTasks (array): excludes specified task indices
    %   -truthFile (str): .mat file with known sentences
    %   -dictFile (str): dictionary file with word to phoneme mappings
    %
    % Returns:
    %   -none

    % Full file path
    inFile = sprintf('%s%s%s%s', inDir, subject, filesep, inFile);

    % Load necessary files
    load(inFile); 
    load(truthFile);
    load(dictFile);

    allTaskInfo = struct([]);

    % Iterate over tasks and aggregate scores over sentences
    k = 1;
    for i = 1:numel(taskListObj.taskList)
        % Skip the training task and only score the test tasks
        if strcmp(taskListObj.taskList{i}.taskTitle, 'Test Automated Vocoder Training')
            continue
        % Skip the excluded tasks
        elseif any(ismember(excludedTasks, i))
            continue
        else
            taskInfo = scoreTask(taskListObj.taskList{1, i}, sentenceStruct, dictionary, scorePhonemes);

            % Format into structure array
            fields = fieldnames(taskInfo);
            for j = 1:numel(fields)
                allTaskInfo(k).(fields{j}) = taskInfo.(fields{j});
            end
            k = k+1;
        end
    end

    % Sorts conditions in alphabetical/numeric order
    if isSorted
        % Sort on condition and isMitigated
        conditions = fields(~strcmp(fields, 'performance'));
        T = struct2table(allTaskInfo);
        sortedT = sortrows(T, conditions);
        allTaskInfo = table2struct(sortedT);

        % Combine scores from repeated conditions
        allTaskInfo = combineScoresRepeatedTasks(allTaskInfo);

        outFile = sprintf('%s%s%s%s', outDir, subject, filesep, 'scores_sorted.mat');
    % Sorts conditions in chronological order
    else
        outFile = sprintf('%s%s%s%s', outDir, subject, filesep, 'scores_unsorted.mat');
    end

    save(outFile, 'allTaskInfo');
    
end