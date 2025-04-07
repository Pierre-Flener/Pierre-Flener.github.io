% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
int: n; % width (and height) of the magic square
set of int: N = 1..n; % index range for the rows and columns
array[N,N] of var 1..n*n: Magic; % Magic[r,c] = the value at row r and column c of the magic square
int: magicSum = sum(1..n*n) div n; % sum of each row, column, and major diagonal; derived parameter
constraint all_different(Magic) :: domain_propagation;  % all values in the magic square are distinct
constraint forall(r in N)(sum(Magic[r,..]) = magicSum); % each row    sums up to the magic sum
constraint forall(c in N)(sum(Magic[..,c]) = magicSum); % each column sums up to the magic sum
constraint sum([Magic[    i,i] | i in N])  = magicSum;  % major down-diagonal sums up to the magic sum
constraint sum([Magic[n+1-i,i] | i in N])  = magicSum;  % major   up-diagonal sums up to the magic sum
constraint symmetry_breaking_constraint(Magic[1,1] < Magic[1,n] /\ Magic[1,n] < Magic[n,1] /\ Magic[1,1] < Magic[n,n]); % 3 rotation & 4 reflection symmetries
solve :: int_search(Magic,occurrence,indomain_split) satisfy;
output ["Magic sum: \(magicSum) \n"] ++ [show2d(Magic)];