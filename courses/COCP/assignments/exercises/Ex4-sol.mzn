include "globals.mzn";

int: n = 4;

array[1..n] of var 1..n*n: X;
array[int] of var int: Y = [abs(X[i]-X[j]) | i,j in 1..n where i<j];

constraint all_different(X);
constraint all_different(Y);

output [show(X), "\n", show(Y)];