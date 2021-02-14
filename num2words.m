% num2words
% Author: Kevin Chu
% Last Modified: 10/30/2020

function words = num2words(number)
    % This function takes numbers written in Arabic numerals and converts
    % them to their written representation in English. For instance, an
    % input of 14 would yield an output of fourteen. Note that this
    % function currently only supports numbers 0-999.
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
        case 3
            words = convert3DigitNums(number);
        otherwise
            warning('Can only handle numbers 0-999.');
            words = number;
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
        case num2cell(20:29)
            first_word = 'twenty';
        case num2cell(30:39)
            first_word = 'thirty';
        case num2cell(40:49)
            first_word = 'forty';
        case num2cell(50:59)
            first_word = 'fifty';
        case num2cell(60:69)
            first_word = 'sixty';
        case num2cell(70:79)
            first_word = 'seventy';
        case num2cell(80:89)
            first_word = 'eighty';
        case num2cell(90:99)
            first_word = 'ninety';
    end
    
    if number > 20
        if mod(number, 10) == 0
            words = first_word;
        else
            second_word = convert1DigitNums(mod(number, 10));
            words = strjoin({first_word,second_word}, ' ');
        end
    end
    
end

function words = convert3DigitNums(number)
    % Converts three digit numbers into written representation
    %
    % Args:
    %   number (double): number to convert
    %
    % Returns:
    %   words (str): written representation
    
    first_word = convert1DigitNums(floor(number/100));
    second_word = convert2DigitNums(mod(number, 100));
    words = strjoin({first_word, 'hundred', second_word}, ' ');
    
end