function put_stroop_inFigure(ink, word, loc)
% put_stroop_inFigure function places a word (word), with a color (ink)
% at a location in a figure.
% (By Lisa Thelen and Lizzy Da Rocha Bazilio)

% INPUT:
% ink = string that gives the colour of the ink ('r', 'g', 'b', 'y')
% word = string that gives word ('red', 'green', 'blue', 'yellow')
% loc = x-coordinate, y-coordinate

	g=text(loc(1), loc(2), word,...
        'HorizontalAlignment', 'center');
    set(g, 'color', ink);
    set(g, 'FontSize', 50);

    xlim([0 5]);
    ylim([0 5]);
end
