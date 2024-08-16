include "globals.mzn";

int: n = 4;

array[1..n] of var 1..n*n: X;
array[...] of var int: Y = [... | ...];

constraint all_different(X);
constraint all_different(Y);

output [show(X), "\n", show(Y)];