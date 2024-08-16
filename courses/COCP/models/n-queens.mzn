% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
int: n; % number of queens
array[1..n] of var 1..n: Row; % Row[c] = the row of the queen in column c; enforces that all queens are in distinct columns
constraint all_different( Row                  ); % all queens are in distinct rows
constraint all_different([Row[c]+c | c in 1..n]); % all queens are in distinct   up-diagonals
constraint all_different([Row[c]-c | c in 1..n]); % all queens are in distinct down-diagonals
solve :: int_search(Row, first_fail, indomain_median) satisfy;