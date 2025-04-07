int: n = 2;
int: m = 3;
array[1..m] of int: A = [1,2,1];

array[1..m*n] of int: B = [... | ...];

constraint assert(B = [1,1,2,2,1,1], "B does not match the expected value.");
output [show(B)];