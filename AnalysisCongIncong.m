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
title('Mean Reaction Time per Condition', 'fontsize', 30);
xlabel('Condition', 'fontsize', 20)
ylabel('Mean Reaction Time', 'fontsize', 20)
set(gca, 'XTick', [0 10], 'XTickLabel', [{'Congruent', 'Incongruent'}],'FontSize', 15, 'FontName', 'Times New Roman');
set(gca, 'color', 'k')
xlim([-1 11]);
ylim([0.7 1.7]);
hold on

cond = {'cong', 'incong'}

%% Data retrieval from vector of structs "data"
% Retrieve data of 'dcol' condition 
Data_SameWord = StroopData(:,find(strcmp([StroopData.Combination], 'SameWord') == 1));
Data_SameWord = Data_SameWord(find([Data_SameWord.Correctness]));


% Retrieve data of 'dsym' condition 
Data_SameInk = StroopData(:,find(strcmp([StroopData.Combination], 'SameInk') == 1))
Data_SameInk = Data_SameInk(find([Data_SameInk.Correctness])); 

% Retrieve data of 'dsym' condition 
Data_Standard = StroopData(:,find(strcmp([StroopData.Combination], 'none') == 1))
Data_Standard = Data_Standard(find([Data_Standard.Correctness])); 


% Retrieve data of 'c' condition
Data_SameAll = StroopData(:,find(strcmp([StroopData.Combination], 'SameAll') == 1));
Data_SameAll = Data_SameAll(find([Data_SameAll.Correctness]));

% Retrieve data of 'c' condition
Data_Diff = StroopData(:,find(strcmp([StroopData.Combination], 'Diff') == 1));
Data_Diff = Data_Diff(find([Data_Diff.Correctness]));


%% Plot the data points of the reaction times of the correct trials
% Plotting all individual data points of the correct trials
% per condition
for i_condition = 1:2
    plotdata(i_condition).SameWord = [Data_SameWord(find(strcmp([Data_SameWord.Condition],cond(i_condition)))).Time];
    plotdata(i_condition).SameInk = [Data_SameInk(find(strcmp([Data_SameInk.Condition], cond(i_condition)))).Time];
    plotdata(i_condition).Standard = [Data_Standard(find(strcmp({Data_Standard.Condition}, cond(i_condition)))).Time];
    plotdata(i_condition).SameAll = [Data_SameAll(find(strcmp([Data_SameAll.Condition], cond(i_condition)))).Time];
    plotdata(i_condition).Diff = [Data_Diff(find(strcmp([Data_Diff.Condition], cond(i_condition)))).Time];
end

%% Calculate the mean values for each condition (cond)
% Initialize mean variables for each condition
Mean_SameWord = [];
Mean_SameInk = [];
Mean_Standard = [];
Mean_SameAll = [];
Mean_Diff = [];

% Creating the mean value of each condition per set size using the 
% plots of hits per set size 
for i_condition2 = 1:2
    Mean_SameWord = [Mean_SameWord,mean(plotdata(i_condition2).SameWord)]
    Mean_SameInk = [Mean_SameInk,mean(plotdata(i_condition2).SameInk)];
    Mean_Standard = [Mean_Standard,mean(plotdata(i_condition).Standard)];
    Mean_SameAll = [Mean_SameAll,mean(plotdata(i_condition2).SameAll)];
    Mean_Diff = [Mean_Diff,mean(plotdata(i_condition2).Diff)];
end

cond = [0, 10]

%% Plot the mean lines
% Drawing a line trough the mean values per condition per set size
line(cond,Mean_SameWord,'color','b');

line(cond,Mean_SameInk,'color','r');

line(cond, Mean_Standard, 'color', 'g');

line(cond,Mean_SameAll,'color','y');

line(cond,Mean_Diff,'color','m');

%% Add a legend for each condition
% Creating a legend that shows what the different colours ans symbols 
% stand for in terms of the different conditions
legend('SameWord', 'SameInk', 'Standard', 'SameAll','Diff', 'TextColor', 'w', 'Location','NorthWest')

%% write to exel file
writetable(struct2table(StroopData), 'Stroop.xlsx');