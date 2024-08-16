int: n = 3;
int: m = 3;
array[1..m] of int: A = [1,2,3];

array[1..m*n] of int: B = [ ... | ... ];

constraint assert(B = [1,2,3,1,2,3,1,2,3], "B does not match the expected value.");
output [show(B)];