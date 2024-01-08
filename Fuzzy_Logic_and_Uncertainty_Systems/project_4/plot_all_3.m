%----------------------------------------------------------------
%       FUZZY AND UNCERTAINTY SYSTEMS
%       Winter 2023-2024
%       function plot_all_3(x, A, Abar, y, B, Bbar, z, C, Cbar, winputs);
%       This function plots A, A', B, B' and C, C' of a two-input
%       fuzzy rule
%       Author: Prof.Paris Mastorocostas
%----------------------------------------------------------------

% Προσθέσαμε στην συνάρτηση την δυνατότητα να δίνουμε τίτλους στα διαγράμματα μέσω ορισμάτων.

function plot_all_3(x, a, a_bar, y, b, b_bar, z, c, c_bar, winputs, title1, title2, title3)
subplot(311)
plot(x, a)
hold on
plot(x, a_bar)
w_line = winputs(1)*ones(size(x));
plot(x, w_line, '--k')
title(title1)
hold off
subplot(312)
plot(y, b)
hold on
plot(y, b_bar)
w_line = winputs(2)*ones(size(y));
plot(y, w_line, '--k')
title(title2)
hold off
subplot(313)
plot(z, c)
hold on
area(z, c_bar)
title(title3)
end
