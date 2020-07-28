% parseFilename.m
% Author: Kevin Chu
% Last Modified: 01/21/2020

function file = parseFilename(wavfile)
    % Parses filename into list and sentence number. Assumes naming
    % convention of HINT sentences (HINT_L#_s#).
    %
    % Args:
    %   -wavfile (str): name of current file
    %
    % Returns:
    %   -file (struct): structure with fields
    %       -list (double): list number
    %       -sent (double): sentence number

    match = regexp(wavfile, '_L\d{1,2}_', 'match'); % for HINT sentences
    file.list = str2double(regexprep(match{1}, '\D', ''));    
    match = regexp(wavfile, '_s\d{1,2}', 'match');
    file.sent = str2double(regexprep(match{1}, '\D', ''));

end