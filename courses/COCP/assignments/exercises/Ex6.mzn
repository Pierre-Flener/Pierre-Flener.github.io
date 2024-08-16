int: n = 4;

array[...,...] of ...: A = ...;

constraint assert(A = [|1,2,6|1,3,7|1,4,8|2,3,11|2,4,12|3,4,16|], "A does not match the expected value.");
output [show2d(A)];