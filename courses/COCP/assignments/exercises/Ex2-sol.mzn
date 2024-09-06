int: n = 5;
int: m = 6;
array[1..m] of int: A = [1,2,3,4,5,6];

array[1..m*n] of int: B = [ a | i in 1..n, a in A];

output [show(B)];