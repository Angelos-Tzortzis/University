%----------------------------------------------------------------
%       FUZZY AND UNCERTAINTY SYSTEMS
%       Winter 2020-2021
%       function sim=similarity_measure(y1,y2)
%       This function provides the similarity measure
%       of two fuzzy sets
%       Author: Prof. Paris Mastorocostas
%----------------------------------------------------------------

function sim = similarity_measure(y1,y2)
% w_inter = min(y1, y2);
% w_union = max(y1, y2);
% x_inter = sum(w_inter);
% x_union = sum(w_union);
% sim = x_inter/x_union;

% Alternative, more compact implementation.
sim = sum(min(y1, y2))/sum(max(y1, y2));
end
