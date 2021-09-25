% DataAnalysis script plots a figure displaying the results of a
% StroopTask experiment.
% (By Lisa Thelen and Lizzy Da Rocha Bazilio)

%% Load the data files and prepare the figure
% Prompt user to load the data file containing results of 
% the visual search task for one subject
uiopen('load')

% Prepare figure
ResultPlot = figure('units','normalized',...
    'outerposition',[0 0 1 1]);

% Set axes
title('Stroop Task: Reaction Time over Trial Number', 'fontsize', 40);
xlabel('Trial Number', 'fontsize', 20)
ylabel('Mean Reaction Time for each Trial', 'fontsize', 20)
set(gca, 'YTick', [1.2 3.5 6 9 11], 'YTickLabel', [{'Diff','SameAll', 'Standard', 'SameInk', 'SameWord'}],'FontSize', 10, 'FontName', 'Times New Roman');
set(gca, 'color', 'k')
ylim([0.5 13]);
hold on

cond = {'cong', 'incong'}

%% Data retrieval from vector of structs "data"
%Initialize Variables
Mean_SameWord = [];
SameWordTrials = [];
Mean_SameInk = [];
SameInkTrials = [];
Mean_Standard = [];
StandardTrials = [];
Mean_SameAll = [];
SameAllTrials = [];
Mean_Diff = [];
DiffTrials = [];

%Etract for each trial number the reaction time of each participant and put
% it in a vector
for i = 1:max([StroopData.TrialNumber])
    Data_SameWord = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData(:).Combination], 'SameWord') == 1 & [StroopData(:).TrialNumber] == i).Time]; 
    SameWordTrials(i) = i
    Mean_SameWord(i) = [mean(Data_SameWord)];    %calculate the mean of the
                                                 % reaction time between
                                                 % participants per trial
end

for i = 1:max([StroopData.TrialNumber])
    Data_SameInk = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData(:).Combination], 'SameInk') == 1 & [StroopData(:).TrialNumber] == i).Time]; 
    SameInkTrials(i) = i
    Mean_SameInk(i) = [mean(Data_SameInk)];
end

for i = 1:max([StroopData.TrialNumber])
    Data_Standard = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData(:).Combination], 'none') == 1 & [StroopData(:).TrialNumber] == i).Time]; 
    StandardTrials(i) = i
    Mean_Standard(i) = [mean(Data_Standard)];
end

for i = 1:max([StroopData.TrialNumber])
    Data_SameAll = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData(:).Combination], 'SameAll') == 1 & [StroopData(:).TrialNumber] == i).Time]; 
    SameAllTrials(i) = i
    Mean_SameAll(i) = [mean(Data_SameAll)];
end

for i = 1:max([StroopData.TrialNumber])
    Data_Diff = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData(:).Combination], 'Diff') == 1 & [StroopData(:).TrialNumber] == i).Time]; 
    DiffTrials(i) = i
    Mean_Diff(i) = [mean(Data_Diff)];
end

%% Plot data
idx = ~any(isnan(Mean_SameWord),1);
plot(SameWordTrials(idx),Mean_SameWord(idx)+ 10, '-b');
hold on
idx = ~any(isnan(Mean_SameInk),1);
plot(SameInkTrials(idx),Mean_SameInk(idx)+ 7.5, '-r');
hold on
idx = ~any(isnan(Mean_Standard),1);
plot(StandardTrials(idx),Mean_Standard(idx)+ 5, '-g');
hold on
idx = ~any(isnan(Mean_SameAll),1);
plot(SameAllTrials(idx),Mean_SameAll(idx)+ 2.5, '-y');
hold on
idx = ~any(isnan(Mean_Diff),1);
plot(DiffTrials(idx),Mean_Diff(idx), '-m');

