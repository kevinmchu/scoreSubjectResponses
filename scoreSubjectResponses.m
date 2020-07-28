% scoreSubjectResponses.m
% Author: Kevin Chu
% Last Modified: 03/27/2020

% DESCRIPTION: This script extracts a subject's responses from their .mat 
% file and calculates the score for each task.

clear; close all; clc;

%% USER INPUTS
subject = 'subject01';
inDir = './';
outDir = './';
inFile = 'taskList_Final.mat';
outFile = 'scores.mat';
truthFile = 'truth_files/hintListTruth.mat';
dictFile = 'dictionary.mat';

%% CODE
% Full file path
inFile = sprintf('%s%s%s%s', inDir, subject, filesep, inFile);
outFile = sprintf('%s%s%s%s', outDir, subject, filesep, outFile);

% Load necessary files
load(inFile); 
load(truthFile);
load(dictFile);

allTaskInfo = struct([]);

% Iterate over tasks and aggregate scores over sentences
k = 1;
for i = 1:numel(taskListObj.taskList)
    % Skip the training task and only score the test tasks
    if ~strcmp(taskListObj.taskList{i}.taskTitle, 'Test Automated Vocoder Training')
        taskInfo = scoreTask(taskListObj.taskList{1, i}, sentenceStruct);

        % Format into structure array
        fields = fieldnames(taskInfo);
        for j = 1:numel(fields)
            allTaskInfo(k).(fields{j}) = taskInfo.(fields{j});
        end
        k = k+1;
    end
end

% Sort on condition and isMitigated
conditions = fields(~strcmp(fields, 'performance'));
T = struct2table(allTaskInfo);
sortedT = sortrows(T, conditions);
allTaskInfo = table2struct(sortedT);

% Combine scores from repeated conditions
allTaskInfo = combineScoresRepeatedTasks(allTaskInfo);

save(outFile, 'allTaskInfo');