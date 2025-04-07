include "globals.mzn";
int: n = 3;
array[1..n] of int: A = [2,1,3];
array[1..n] of int: B = [9,7,5];

array[1..n] of int: C = [... | ...];

constraint assert(C = [7,9,5], "C does not match the expected value.");

output [show(C)];