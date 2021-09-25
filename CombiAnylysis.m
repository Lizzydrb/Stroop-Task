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
title('Reaction Times per Combination', 'fontsize', 30);
xlabel('Condition', 'fontsize', 20)
ylabel('Reaction Time', 'fontsize', 20)
set(gca,'FontName', 'Times New Roman')
x = categorical({'Congruent SameWord';'Congruent SameInk';'Congruent Standard';'Congruent SameAll'; 'Congruent Diff';'';'Incongruent SameWord';'Incongruent SameInk';'Incongruent Standard';'Incongruent SameAll';'Incongruent Diff'});
xticklabels(x);
ylim([0.5 2]);

x_labels_Congruent = categorical({'Congruent SameWord','Congruent SameInk', 'Congruent Standard', 'Congruent SameAll', 'Congruent Diff','-'});
x_labels_Congruent = reordercats(x_labels_Congruent,{'Congruent SameWord','Congruent SameInk','Congruent Standard', 'Congruent SameAll', 'Congruent Diff','-'});
x_labels_Incongruent = categorical({'Incongruent SameWord','Incongruent SameInk','Incongruent Standard','Incongruent SameAll', 'Incongruent Diff'});
x_labels_Incongruent = reordercats(x_labels_Incongruent,{'Incongruent SameWord','Incongruent SameInk','Incongruent Standard','Incongruent SameAll', 'Incongruent Diff'});
hold 

%% extract data 
SameWord_RT_Congruent = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData.Condition], 'cong') == 1 & strcmp([StroopData.Combination], 'SameWord') == 1).Time];
SameWord_RT_Incongruent = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData.Condition], 'incong') == 1 & strcmp([StroopData.Combination], 'SameWord') == 1).Time];

SameInk_RT_Congruent = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData.Condition], 'cong') == 1 & strcmp([StroopData.Combination], 'SameInk') == 1).Time];
SameInk_RT_Incongruent = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData.Condition], 'incong') == 1 & strcmp([StroopData.Combination], 'SameInk') == 1).Time];

Standard_RT_Congruent = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData.Condition], 'cong') == 1 & strcmp([StroopData.Combination], 'none') == 1).Time];
Standard_RT_Incongruent = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData.Condition], 'incong') == 1 & strcmp([StroopData.Combination], 'none') == 1).Time];

SameAll_RT_Congruent = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData.Condition], 'cong') == 1 & strcmp([StroopData.Combination], 'SameAll') == 1).Time];
SameAll_RT_Incongruent = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData.Condition], 'incong') == 1 & strcmp([StroopData.Combination], 'SameAll') ==1).Time];

Diff_RT_Congruent = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData.Condition], 'cong') == 1 & strcmp([StroopData.Combination], 'Diff') == 1).Time];
Diff_RT_Incongruent = [StroopData([StroopData(:).Correctness] == 1 & strcmp([StroopData.Condition], 'incong') == 1 & strcmp([StroopData.Combination], 'Diff') == 1).Time];

%% Calculate mean values
mean_SameWord_RT_Congruent = mean(SameWord_RT_Congruent);
mean_SameWord_RT_Incongruent = mean(SameWord_RT_Incongruent);

mean_SameInk_RT_Congruent = mean(SameInk_RT_Congruent);
mean_SameInk_RT_Incongruent = mean(SameInk_RT_Incongruent);

mean_Standard_RT_Congruent = mean(Standard_RT_Congruent);
mean_Standard_RT_Incongruent = mean(Standard_RT_Incongruent);

mean_SameAll_RT_Congruent = mean(SameAll_RT_Congruent);
mean_SameAll_RT_Incongruent = mean(SameAll_RT_Incongruent);

mean_Diff_RT_Congruent = mean(Diff_RT_Congruent);
mean_Diff_RT_Incongruent = mean(Diff_RT_Incongruent);

mean_Congruent = [mean_SameWord_RT_Congruent, mean_SameInk_RT_Congruent, mean_Standard_RT_Congruent, mean_SameAll_RT_Congruent, mean_Diff_RT_Congruent, NaN];
mean_Incongruent = [mean_SameWord_RT_Incongruent, mean_SameInk_RT_Incongruent, mean_Standard_RT_Incongruent, mean_SameAll_RT_Incongruent, mean_Diff_RT_Incongruent];



%% Plot Data 
p1 = plot(x_labels_Congruent, mean_Congruent,'b-','LineWidth', 1); 
p2 = plot(x_labels_Congruent(1), SameWord_RT_Congruent, 'kx', x_labels_Congruent(2), SameInk_RT_Congruent, 'ko', x_labels_Congruent(3), Standard_RT_Congruent, 'ks', x_labels_Congruent(4), SameAll_RT_Congruent, 'kd',  x_labels_Congruent(5), Diff_RT_Congruent, 'k*')
p3 = plot(x_labels_Incongruent, mean_Incongruent,'r-','LineWidth', 1);
p4 = plot(x_labels_Incongruent(1), SameWord_RT_Incongruent, 'kx', x_labels_Incongruent(2), SameInk_RT_Incongruent, 'ko' , x_labels_Incongruent(3), Standard_RT_Incongruent, 'ks', x_labels_Incongruent(4), SameAll_RT_Incongruent, 'kd', x_labels_Incongruent(5),  Diff_RT_Incongruent, 'k*')

legend([p1 p3],{'Mean of correct congruent trials','Mean of correct incongruent trials'}, 'Location', 'northwest')
