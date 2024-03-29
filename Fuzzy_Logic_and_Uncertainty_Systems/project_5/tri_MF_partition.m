%------------------------------------------------------------------
%       function [Alpha, Beta, Gamma] = tri_MF_partition(low, high, n, g)
%       This function partitions the input space to the
%       triangular membership functions
%       Author: Dr.Paris Mastorocostas
%------------------------------------------------------------------

function [alpha, beta, gamma] = tri_MF_partition(low, high, n, g)
temp1 = 0.5/(1 - g);
temp2 = (high - low)/(n - 1);

for k = 1:n
  beta(k) = low + (k - 1)*temp2;
  
  if k == 1
    alpha(k) = low;
  else
    alpha(k) = low + temp2*(k - 1 - temp1);
  end
  if k == n
    gamma(k) = high;
  else
    gamma(k) = low + temp2*(k - 1 + temp1);
  end
end
end
