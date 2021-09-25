%% Stroop task script
% This script runs the complete Stroop Task experiment
% (Standard and with a Twist).
% (By Lisa Thelen and Lizzy Da Rocha Bazilio)

%% Clear workspace and command window
clear
clc

%% Ensure randoms starts with a different seed
rng('shuffle')

%% Set up the interface
fig = figure('units','normalized','color', [0 0 0],...
    'outerposition',[0 0 1 1]);

ax = axes(fig,'xcolor',get(gcf,'color'),...
    'position', [0 0 1 1],...
    'xtick',[],'color', [0 0 0],...
    'ycolor',get(gcf,'color'),...
    'ytick',[]);
xlim([0 5])
ylim([0 5])

% Ask the subject to fill in their anonymous participant number
ID = str2double(inputdlg('Please enter the participant number you were handed randomly to ensure anonymity: '));
validateattributes(ID,{'numeric'},{'nonempty','positive', 'integer', 'scalar'},mfilename,'Participant Number',1)

% Welcome Message
[textbox] = popupWhite('Welcome to this experiment!\nWe will start with a practice round for the Standard Stroop Task.\n After the practice round, we will continue with the actual Standard Stroop Task.\n\nPress any key to continue to the instructions.',fig)
pause
delete(textbox)

% Instructions
[textbox] = popupWhite('Instructions Standard Stroop Task:\n\nThe task is to indicate the color of the ink by pressing the corresponding keys.\n(NOT the color that the word describes!)\n\nPress any key to see which keys to press.',fig)
pause
delete(textbox)

% Keys
[textbox] = popupWhite('Keys:\n\n- For red ink press ''r''\n- For green ink press ''g''\n- For blue ink press ''b''\n- For yellow ink press ''y''\n\nPress any key to continue.', fig)
pause
delete(textbox)

% Fixation instructions
[textbox] = popupWhite('Start each trial with attending to the white fixation cross in the middle of the screen.\n\nPress any key to start the practice round.', fig)
pause
delete(textbox)

%% Practice round Standard Stroop Task
% Initialize variables
PracticeTNr = 0;
CorrectCountC = 0;
CorrectCountI = 0;
combi = '';
checkPractice = [10 10];

% Subject has to have least 6 correct answers in both conditions (12 total)
% If this is not the case, start block of 20 trials again
if CorrectCountC < 6 && CorrectCountI < 6
    PracticeTNr = 0;
    
    % Run the practice round
    % Practice round consists of 20 trials
    while PracticeTNr < 20
        PracticeTNr = PracticeTNr +1;
        
        % Randomly pick a condition each trial
        cond = pickone({'cong', 'incong'});
        
        % Count down every trial for each condition
        if strcmp(cond, 'cong')
            checkPractice(1) = checkPractice(1) -1;
        else checkPractice(2) = checkPractice(2) -1;
        end
        
        % When a condition is shown 10 trials, only show other condition
        if checkPractice(1) < 0
            cond = 'incong';
        elseif checkPractice(2) < 0
            cond = 'cong';
        end
        
        % Run the Standard Stroop Task 
        [inkT, reactionTime, correct, key] = run_Ridley(cond, combi)
        
        % Clear all
        cla
        
        % Count number of correct answers for each condition
        if strcmp(cond, 'cong') == 1 && correct == 1
            CorrectCountC = CorrectCountC + 1;
        elseif strcmp(cond, 'incong') == 1 && correct == 1
            CorrectCountI = CorrectCountI + 1
        end
        
        % Give feedback after each answer
        if correct == 0
            [textbox] = popupWhite('Your answer was wrong!\nPay attention and make sure you press the right key.\n\nPress any key to continue.', fig)
            pause
            delete(textbox)
        else % correct == 1
            [textbox] = popupWhite('Your answer was correct!\nGood Job.\n\nPress any key to continue.', fig)
            pause
            delete(textbox)
        end    
    end
end

%% Standard Stroop Task
% Introduction message
[textbox] = popupWhite('You have completed the practice round!\n\n We will now continue to the actual Standard Stroop Task.\nThe task stays the same as in the practice round.\n\n Good luck!\n\nPress any key to start the experiment.', fig)
pause
delete(textbox)

% Initialize variables
CongCount = 0;
IncongCount = 0;
TrialNr = 0;

% Standard Stroop Task consists of at least 15 trials for each condition
while CongCount < 15 && IncongCount < 15
    TrialNr = TrialNr + 1;
    
    % Randomly pick a condition each trial
    cond = pickone({'cong', 'incong'});
    
    % Run the Standard Stroop Task
    [inkT, reactionTime, correct, key] = run_Ridley(cond, combi)
    
    % Store the data in a vector of structs
    SdStroopData(TrialNr).Condition = cond;
    SdStroopData(TrialNr).Ink = inkT;
    SdStroopData(TrialNr).Answer = key;
    SdStroopData(TrialNr).Correctness = correct;
    SdStroopData(TrialNr).Time = reactionTime;
    SdStroopData(TrialNr).SubjectID = ID;
    SdStroopData(TrialNr).TrialNumber = TrialNr;
    
    % Clear all
    cla
    
    % Display a pop up message when subject does not press the instructed keys
    if (strcmpi(key, 'r') || strcmpi(key, 'g') || strcmpi(key, 'b') || strcmpi(key, 'y')) == 0
        [textbox] = popupWhite('Please make sure you press the right keys.\n\n Press any key to continue.', fig);
        pause
        delete(textbox)
    end
    
    % Count number of trials for each condition
    if strcmp(cond, 'cong') == 1
        CongCount = CongCount + 1;
    elseif strcmp(cond, 'incong') == 1
        IncongCount = IncongCount +1;
    end
end
%% Save the data from Standard Stroop Task
filename = int2str(ID);
save(filename, 'SdStroopData')
        
%% Practice round Twist Stroop Task
% Introduction message
[textbox] = popupWhite('You have completed the Standard Stroop task!\n\nNow we will move on to the Stroop Task with a twist.\nAgain, we will start with a practice round.\n\nPress any key to continue to the instructions.',fig)
pause
delete(textbox)

% Instructions
[textbox] = popupWhite('Instructions Twist Stroop Task:\n\nIn the Standard Stroop Task you had to indicate the color of the ink of a word.\nThis is also the case in the Twist Stroop Task.\n\nPress any key for further instructions.',fig)
pause
delete(textbox)

[textbox] = popupWhite('Instructions:\n\nIn this task two words will be displayed.\nPlease indicate the color of the ink of the word which the arrow points to.\n\nPress any key to continue.', fig)
pause
delete(textbox)

% Keys
[textbox] = popupWhite('Keys:\n\n- For red ink press ''r''\n- For green ink press ''g''\n- For blue ink press ''b''\n- For yellow ink press ''y''\n\nPress any key to start the practice round.', fig)
pause
delete(textbox)

% Initialize variables
PracticeTNr = 0;
CorrectCountSW = 0;
CorrectCountSI = 0;
CorrectCountSA = 0;
CorrectCountDI = 0;

% Subject has to have at least 3 correct answers for each combination (12 total)
% If this is not the case, start block of 20 trials again
if CorrectCountSW < 3 && CorrectCountSI < 3 && CorrectCountSA < 3 && CorrectCountDI < 3
    PracticeTNr = 0
    
    % Run the practice round
    % Practice round consists of 20 trials
    while PracticeTNr < 20
        PracticeTNr = PracticeTNr +1;
        
        % Initialize conditions and combination
        condition = {'cong', 'incong'}
        combination = {'SameWord', 'SameInk', 'SameAll', 'Diff'}
        
        % Randomly pick a condition and combination
        con_rand = randi(2)
        com_rand = randi(4)
        
        cond = condition(con_rand)
        combi = combination(com_rand)
        
        % Initialize ink colors and words
        InkVector = {'r', 'g', 'b', 'y'}
        WordVector = {'RED', 'GREEN', 'BLUE', 'YELLOW'}
        
        % Randomly pick target ink color and word
        inkt_rand = randi(4)
        inkT = InkVector(inkt_rand)
        
        % Run the Twist Stroop Task
        [inkT, reactionTime, correct, key] = run_Ridley(cond, combi)
        
        % Clear all
        cla
        
        % Display a pop up message when subject does not press the instructed keys
        if (strcmpi(key, 'r') || strcmpi(key, 'g') || strcmpi(key, 'b') || strcmpi(key, 'y')) == 0
            [textbox] = popupWhite('Please make sure you press the right keys.\n\n Press any key to continue', fig);
            pause
            delete(textbox)
        end
        
        % Count correct answers for each combination
        if strcmp(combi,'SameWord') == 1 && correct == 1
            CorrectCountSW = CorrectCountSW + 1;
        elseif strcmp(combi,'SameInk') == 1 && correct == 1
            CorrectCountSI = CorrectCountSI + 1;
        elseif strcmp(combi, 'SameAll')== 1 && correct == 1
            CorrectCountSA = CorrectCountSA + 1;
        elseif strcmp(combi, 'Diff') == 1 && correct == 1
            CorrectCountDI = CorrectCountDI + 1;
        end
    end
end

%% Twist Stroop Task
% Initialize variables
TrialNumber = 0;
BlockEnd = 0;
check = zeros(2,4);

% Introduction message
[textbox] = popupWhite('You have completed the practice trials for the Stroop Task with a twist.\nGood job!\n\nYou will now continue to the actual Twist Stroop Task.\nThe instructions are the same.\n\nPress any key to start the experiment.\n\nGood luck!', fig)
pause
delete(textbox)

% Task consists of at least 120 trials (8*15)
% For each combination of condition and combination,
% subjects must have at least 15 correct
while TrialNumber < 240 && min(check, [], 'all') < 15
    
    % Initialize conditions and combinations
    condition = {'cong', 'incong'}
    combination = {'SameWord', 'SameInk', 'SameAll', 'Diff'}
    
    % Randomly pick a condition and combination
    con_rand = randi(2)
    com_rand = randi(4)
    
    cond = condition(con_rand)
    combi = combination(com_rand)
    
    % Increase trial number and block end number for every trial
    TrialNumber = TrialNumber + 1;
    BlockEnd = BlockEnd + 1;
    
    % Give the subject a break after 40 trials
    if BlockEnd == 41 && TrialNumber < 239
        BlockEnd = 0;
        [textbox] = popupWhite('Take a break before you continue.\n\nThe task stays the same.\n\nPress any key to start again.', fig);
        pause
        delete(textbox)
    end
    
    % Run the Twist Stroop Task
    [inkT, reactionTime, correct, key] = run_Ridley(cond, combi)
    
    % Store the data in a vector of structs
    StroopData(TrialNumber).Condition = cond;
    StroopData(TrialNumber).Combination = combi;
    StroopData(TrialNumber).TargetInk = inkT;
    StroopData(TrialNumber).Answer = key;
    StroopData(TrialNumber).Correctness = correct;
    StroopData(TrialNumber).Time = reactionTime;
    StroopData(TrialNumber).SubjectID = ID;
    StroopData(TrialNumber).TrialNumber = TrialNumber;
    StroopData(TrialNumber).TimeofBreak = BreakTime;
    
    % Clear all
    cla
    
    % Count correct trials for each combination of condition and
    % combination in the matrix
    if correct == 1
        check(con_rand, com_rand) = check(con_rand, com_rand) + 1;
    end
    
    % Display a pop up message when subject does not press the instructed keys
    if (strcmpi(key, 'r') || strcmpi(key, 'g') || strcmpi(key, 'b') || strcmpi(key, 'y')) == 0
        [textbox] = popupWhite('Please make sure you press the right keys.\n\n Press any key to continue.', fig);
        pause
        delete(textbox)
    end  
end
  
%% End experiment
% Display a final message
popupWhite('The task is completed, thank you for participating!\n\nGoodbye!\n\n\nPress any key to close the screen.', fig);
pause
close all

%% Save the data 
filename = int2str(ID);
save(filename, 'StroopData')