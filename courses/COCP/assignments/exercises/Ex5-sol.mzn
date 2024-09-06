include "globals.mzn";
int: n = 3;
array[1..n] of int: A = [2,1,3];
array[1..n] of int: B = [9,7,5];

array[1..n] of int: C = [B[i] | i in arg_sort(A)];

output [show(C)];