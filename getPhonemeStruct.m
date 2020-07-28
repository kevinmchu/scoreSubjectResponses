% getPhonemeStruct.m
% Author: Kevin Chu
% Last Modified: 03/05/2020

function phonemeStruct = getPhonemeStruct
    % Create structure with list of phonemes and their manners of
    % articulation
    %
    % Args:
    %   -none
    %
    % Returns:
    %   -phonemeStruct (struct)   

    % Phonemes by manner of articulation
    stops = {'B';'D';'G';'P';'T';'K'};
    affricates = {'JH';'CH'};
    fricatives = {'S';'SH';'Z';'ZH';'F';'TH';'V';'DH';'HH'}; 
    nasals = {'M';'N';'NG'};
    semivowels = {'L';'R';'W';'Y'};
    vowels = {'IY';'IH';'EH';'EY';'AE';'AA';'AO';'AW';'AY';'AH';'OH';'OW';'UH';'UW';'ER'};
    
    % Concatenate
    phonemes = [stops;affricates;fricatives;nasals;semivowels;vowels];
    
    phonemeTypes = [repmat({'stop'},numel(stops),1);...
                    repmat({'affricate'},numel(affricates),1);...
                    repmat({'fricative'},numel(fricatives),1);...
                    repmat({'nasal'},numel(nasals),1);...
                    repmat({'semivowel'},numel(semivowels),1);...
                    repmat({'vowel'},numel(vowels),1)];                
                
    phonemeStruct = struct('phoneme', phonemes, 'phonemeType', phonemeTypes);
end