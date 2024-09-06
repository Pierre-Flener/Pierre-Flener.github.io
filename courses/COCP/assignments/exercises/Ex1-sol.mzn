int: n = 5;
int: m = 10;
array[1..m] of int: A = [1,2,1,3,1,4,1,5,1,6];

array[1..m*n] of int: B = [ a | a in A, i in 1..n];

output [show(B)];