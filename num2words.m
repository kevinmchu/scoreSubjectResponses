% num2words
% Author: Kevin Chu
% Last Modified: 01/21/2020

function words = num2words(number)
    % This function takes numbers written in Arabic numerals and converts
    % them to their written representation in English. For instance, an
    % input of 14 would yield an output of fourteen. Note that this
    % function currently only supports numbers 0-19.
    %
    % Args:
    %   -number (double): a number
    %
    % Returns:
    %   -words (str): written representation of the number
    
    num_digits = length(num2str(number));
    
    switch num_digits
        case 1
            words = convert1DigitNums(number);
        case 2
            words = convert2DigitNums(number);
        otherwise
            error('Can only handle numbers 0-19.');
    end

end

function words = convert1DigitNums(number)
    % Converts one digit numbers into written representation
    %
    % Args:
    %   number (double): number to convert
    %
    % Returns:
    %   words (str): written representation
    
    switch number
        case 0
            words = 'zero';
        case 1
            words = 'one';
        case 2
            words = 'two';
        case 3
            words = 'three';
        case 4
            words = 'four';
        case 5
            words = 'five';
        case 6
            words = 'six';
        case 7
            words = 'seven';
        case 8
            words = 'eight';
        case 9
            words = 'nine';
    end

end

function words = convert2DigitNums(number)
    % Converts two digit numbers into written representation
    %
    % Args:
    %   number (double): number to convert
    %
    % Returns:
    %   words (str): written representation
    
    switch number
        case 10
            words = 'ten';
        case 11
            words = 'eleven';
        case 12
            words = 'twelve';
        case 13
            words = 'thirteen';
        case 14
            words = 'fourteen';
        case 15
            words = 'fifteen';
        case 16
            words = 'sixteen';
        case 17
            words = 'seventeen';
        case 18
            words = 'eighteen';
        case 19
            words = 'nineteen';
        otherwise
            error('Can''t handle numbers greater than 19');
    end
    
end