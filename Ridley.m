function [inkT] = Ridley(cond, combi)
% Function Ridley (used for Stroop Task with a Twist)
% creates the target and distractor words and ink colors
% according to the condition and combination,
% and plots them at a location in a figure.
% (By Lisa Thelen and Lizzy Da Rocha Bazilio)

% INPUT:
% condi = 'cong' (congruent) or 'incong' (incongruent)
% combi = 'SameWord', 'SameInk', 'SameAll', 'Diff'
    % 'SameWord' = word target and distractor are same, ink is different
    % 'SameInk' = ink target and distractor are same, word is different
    % 'SameAll' = target is same as distractor
    % 'Diff' = word and ink of target and distractor are different

% OUTPUT:
% inkT = ink colour of the target word

%% Input checks
if ~(strcmpi(cond, 'cong') || strcmpi(cond, 'incong'))
    error('Incorrect condition ''cond''')
end

if ~(strcmpi(combi, 'SameWord') || strcmpi(combi, 'SameInk') || strcmpi(combi, 'SameAll') || strcmpi(combi, 'Diff'))
    error('Incorrect combination ''combi''')
end

%% Determine the location of the target and distractor
% Initialize the two locations (left, right) of the words
locL = [1.75 2.5];
locR = [3.25 2.5];

% Randomize whether target word will be plotted left or right
locT = pickone({locL, locR});

% Set location of distractor word, based on target word
if locT == [1.75 2.5]
    locD = [3.25 2.5];
else
    locD = [1.75 2.5];
end

%% Set the ink and word for the target and distractor
InkVector = {'r', 'g', 'b', 'y'};
WordVector = {'RED', 'GREEN', 'BLUE', 'YELLOW'};

% Pick a random target ink color (each with 1/4 probability)
inkt_rand = randi(4);
inkT = InkVector{inkt_rand};
     
% Pick a target word based on the condition
if strcmp(cond, 'cong')
    wordT = WordVector(inkt_rand);
else % cond = 'incong'
    WordVector(inkt_rand) = [];
    wordT = pickone(WordVector);
    WordVector = {'RED', 'GREEN', 'BLUE', 'YELLOW'};
end

% Pick a distractor word and ink color based on the combination and target
if strcmp(combi,'SameWord')
    wordD = wordT;
    InkVector(inkt_rand) = [];
    inkD = pickone(InkVector);
elseif strcmp(combi, 'SameInk')
    inkD = inkT;
    WordVector(find(strcmp([WordVector], wordT))) = [];
    wordD = pickone(WordVector);
elseif strcmp(combi, 'SameAll')
    wordD = wordT;
    inkD = inkT;
else % combi = 'Diff'
    InkVector(inkt_rand) = [];
    WordVector(find(strcmp([WordVector], wordT))) = [];
    inkD = pickone(InkVector);
    wordD = pickone(WordVector);
end

%% Set the arrow to point to the target
if locT == [1.75 2.5]
    arrows = text(2.5, 2.5, '\leftarrow',...
        'VerticalAlignment', 'middle','color', [1 1 1], 'fontweight', 'bold',...
        'HorizontalAlignment', 'center', 'Fontsize', 70);
else
    arrows = text(2.5, 2.5, '\rightarrow',...
        'VerticalAlignment', 'middle','color', [1 1 1], 'fontweight', 'bold',...
        'HorizontalAlignment', 'center', 'Fontsize', 70);
end

%% Plot the words in a figure at the correct location
put_stroop_inFigure(inkT, wordT, locT)
hold on
put_stroop_inFigure(inkD, wordD, locD)
end