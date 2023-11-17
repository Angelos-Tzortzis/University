%----------------------------------------------------------------
%       FUZZY AND UNCERTAINTY SYSTEMS
%       Winter 2020-2021
%       function my_display(no_of_plots, plot_no,x,y,bar_width,tlt)
%       This function performs a plot according to
%       the specifications given in FIRST PROJECT
%       Author: Prof. Paris Mastorocostas
%----------------------------------------------------------------

function my_display_fully(no_of_plots, plot_no, x, y, bar_width)
subplot(no_of_plots, 1, plot_no);
bar(x, y, bar_width);
axis([min(x) max(x) (min(y) - 0.001) max(y)])
end
