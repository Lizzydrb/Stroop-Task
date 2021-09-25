function [inkT, reactionTime, correct, key] = run_Ridley(cond, combi)
% Function run_Ridley measures the reaction time
% of answering the color of the ink of the target 
% set in the Ridley function.
% (By Lisa Thelen and Lizzy Da Rocha Bazilio)

% INPUT: same as in the Ridley function (see Ridley.m)
% OUTPUT:
% inkT = inkT color of the target word
% reactionTime = reaction time of the answer (key press)
% correct = whether answer given is correct (1) or incorrect (0)
% key = the button pressed (answer)

%% Fixation point
randomtime = [0.5, 1, 1.5]
text(2.5, 2.5,'+', 'HorizontalAlignment', 'center', 'Fontsize',75, 'Color', 'w', 'fontweight', 'bold');
pause(pickone(randomtime))
cla

%% Call the Ridley or RidleyStandard function
if strcmp(combi, '')
    [inkT] = RidleyStandard(cond)
else
    [inkT] = Ridley(cond, combi)   
end

%% Measure the reaction time of a button press
tic
pause
reactionTime = toc;

% Store button press in variable
key = get(gcf, 'CurrentCharacter');

%% Check whether response is correct
if inkT == 'r' && strcmpi(key, 'r') == 1 || inkT == 'g' && strcmpi(key, 'g') || inkT == 'b' && strcmpi(key, 'b') || inkT == 'y' && strcmpi(key, 'y')
    correct = 1
else correct = 0;
end

%% Initiate a black screen after each trial
cla
pause(1)

end
