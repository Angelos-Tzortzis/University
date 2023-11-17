%----------------------------------------------------------------
%       FUZZY AND UNCERTAINTY SYSTEMS
%       Winter 2020-2021
%       function sub=subsethood_measure(y1,y2)
%       This function provides the subsethood measure
%       of two fuzzy sets
%       Author: Prof. Paris Mastorocostas
%-----------------------------------------------------------------

function sub = subsethood_measure(y1, y2)
% z = sum(y1);
% w = min(y1, y2);
% x = sum(w);
% sub = x/z;

% Alternative, more compact implementation.
sub = sum(min(y1, y2)) / sum(y1);
end
