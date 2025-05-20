% Copyright: Pierre.Flener@it.uu.se, course 1DL451, 2025
include "globals.mzn";
array[1..17] of record(2..52: top, 2..52: mid, 2..52: bot): Fan; % precondition: all_different over all 17*3 elements
predicate rankApart(var 1..52: c1, var 1..52: c2) = % cards c1 and c2 are one rank apart; use either line 5 or (best!) line 6 (whose precomputed array is outlined in line 7)
  %  let { array[1..52] of int: Rank = [c mod 13 | c in 1..52] } in Rank[c1] - Rank[c2] in {-12,-1,1,12};
  table([c1,c2], array2d(1..416,1..2, [[c, ((c+13*j+1)-1) mod 52 + 1, c, ((c+13*j+12)-1) mod 52 + 1][k] | c in 1..52, j in 0..3, k in 1..4]));
  %              [|1,2|1,13|...|1,41|1,52|2,3|2,14|...|52,40|52,51|]);
array[1..52] of var 1..52: Card; % Card[p] = the encoding of the card at position p, from bottom to top, in the black hole
constraint Card[1] = 1; % the card at position 1 is A♠
constraint forall(p in 1..51)(rankApart(Card[p],Card[p+1])); % adjacent black-hole cards are a rank apart
%% Use either line 12, or (better!) line 13, or (best!) lines 14 to 17:
% constraint forall(f in Fan)(let { var 2..52: p1; var 2..52: p2; var 2..52: p3 } in Card[p1] = f.top /\ Card[p2] = f.mid /\ Card[p3] = f.bot /\ p1 < p2 /\ p2 < p3); % the black-hole cards respect the order in the given fans
% constraint all_different(Card) /\ forall(f in Fan)(value_precede_chain([f.top,f.mid,f.bot],Card)); % the black-hole cards respect the order in the given fans
array[1..52] of var 1..52: Pos; % Pos[c] = the position of card c in the black hole; mutually redundant with Card
constraint Pos[1] = 1; % the position of card A♠ is 1
constraint forall(f in Fan)(Pos[f.top] < Pos[f.mid] /\ Pos[f.mid] < Pos[f.bot]); % the black-hole cards respect the order in the given fans
constraint inverse(Card,Pos) :: domain_propagation; % 2-way channelling; crucial annotation
solve satisfy;