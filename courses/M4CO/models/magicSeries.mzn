% Copyright: Pierre.Flener@it.uu.se, course 1DL451, 2024
include "globals.mzn";
int: n; % size of the magic series
set of int: I = 0..(n-1);
array[I] of var I: Magic; % Magic[i] = the number at index i of the magic series
%% Use either line 7, or (better!) line 8, or (best!) line 9:
% constraint forall(i in I)(Magic[i] = sum(j in I)(Magic[j] = i));            % each element is equal to the number of occurrences of its index
% constraint forall(i in I)(Magic[i] = count(Magic,i));                       % each element is equal to the number of occurrences of its index
constraint global_cardinality_closed(Magic, array1d(I,I), Magic); % each element is equal to the number of occurrences of its index
constraint implied_constraint(sum(Magic) = n /\ sum(i in I)(i * Magic[i]) = n); % the sum and index-weighted sum are n
solve satisfy;