% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
enum Varieties;
enum Blocks = anon_enum((balance * card(Varieties) * (card(Varieties) - 1)) div (blockSize * (blockSize - 1)));
int: blockSize;
int: sampleSize = (balance * (card(Varieties) - 1)) div (blockSize - 1);
int: balance;
array[Varieties,Blocks] of var 0..1: BIBD; % BIBD[v,b] = 1 iff variety v is in block b
constraint forall(b in Blocks)   (blockSize  = count(BIBD[..,b], 1)); % equal block  sizes
constraint forall(v in Varieties)(sampleSize = count(BIBD[v,..], 1)); % equal sample sizes
constraint forall(v, w in Varieties where v < w)(balance = count([BIBD[v,b] + BIBD[w,b] | b in Blocks], 2)); % balanced samples
constraint symmetry_breaking_constraint(forall(v in Varieties diff {max(Varieties)})(lex_greater  (BIBD[v,..],BIBD[enum_next(v),..])));
constraint symmetry_breaking_constraint(forall(b in Blocks    diff {max(Blocks)})   (lex_greatereq(BIBD[..,b],BIBD[..,enum_next(b)])));
solve :: int_search(BIBD,input_order,indomain_max) satisfy;