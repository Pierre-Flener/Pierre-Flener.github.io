% Copyright: Pierre.Flener@it.uu.se, course 1DL451, 2025
include "globals.mzn";
enum Varieties;
enum Blocks = anon_enum((balance * card(Varieties) * (card(Varieties) - 1)) div (blockSize * (blockSize - 1)));
int: blockSize;
int: sampleSize = (balance * (card(Varieties) - 1)) div (blockSize - 1);
int: balance;
array[Varieties] of var set of Blocks: BIBD; % BIBD[v] = the subset of Blocks for variety v
constraint forall(b in Blocks)   (blockSize  = sum(v in Varieties)(b in BIBD[v])); % equal block  sizes
constraint forall(v in Varieties)(sampleSize = card(BIBD[v]));                     % equal sample sizes
constraint forall(v, w in Varieties where v < w)(balance = card(BIBD[v] intersect BIBD[w])); % balanced samples
solve satisfy;