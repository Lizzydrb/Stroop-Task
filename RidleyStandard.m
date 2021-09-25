function [inkT] = RidleyStandard(cond)
% Function RidleyStandard (used for Standard Stroop Task)
% creates a word and ink color according to the condition,
% and plots them at a set location in a figure.
% (By Lisa Thelen and Lizzy Da Rocha Bazilio)

%% Input checks
if ~(strcmpi(cond, 'cong') || strcmpi(cond, 'incong'))
    error('Incorrect condition ''cond''')
end

%% Initialize tha variables
loc = [2.5 2.5]
InkVector = {'r', 'g', 'b', 'y'};
WordVector = {'RED', 'GREEN', 'BLUE', 'YELLOW'};  

%% Pick the ink colour and word
% Randomly pick an ink color
ink_rand = randi(4);
inkT = InkVector{ink_rand};

% Pick the word, based on the condition and ink color
if strcmp(cond, 'cong')
   wordT = WordVector(ink_rand);
else 
    WordVector(ink_rand) = [];
    wordT = pickone(WordVector)
end 

%% Plot the word in a figure
put_stroop_inFigure(inkT, wordT, loc)
end

