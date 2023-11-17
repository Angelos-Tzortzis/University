function alpha_cuts (no_sets, alpha_val, x, y, figure_no)
figure(figure_no);

for i = 1:no_sets
  index = find(y(i, :) > alpha_val);
  my_display_fully(no_sets, i, x(index), y(i, index), 0.1);
end
end
