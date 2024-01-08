%----------------------------------------------------------------
%       FUZZY AND UNCERTAINTY SYSTEMS
%       Winter 2023-2024
%       function [w, w1, w2] = w_2_inputs(A, A_bar, B, B_bar)
%       This function provides the w coefficient of a 2-input
%       fuzzy rules with Rc and max-min
%       Author: Prof.Paris Mastorocostas
%----------------------------------------------------------------

function [w, winputs]  = w_2_inputs(a, a_bar, b, b_bar)
tomh = min(a, a_bar);
winputs(1) = max(tomh);
tomh = min(b, b_bar);
winputs(2) = max(tomh);
w = min(winputs(1), winputs(2));
end
