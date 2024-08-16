% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
int: nGroups; % number of groups per week
int: nSlots;  % number of players per group
int: nWeeks;  % number of weeks
set of int: Groups  = 1..nGroups;
set of int: Slots   = 1..nSlots;
set of int: Weeks   = 1..nWeeks;
set of int: Players = 1..(nGroups*nSlots);
array[Weeks,Groups,Slots] of var Players: Player; % Player[w,g,s] = the player in slot s of group g in week w
constraint forall(w in Weeks)(alldifferent(Player[w,..,..])); % each week: the groups partition the players
constraint forall(a,b in Players where a != b)(sum(w in Weeks, g in Groups, i,j in Slots where i < j)(Player[w,g,i] = a /\ Player[w,g,j] = b) <= 1); % any two players meet at most once; strengthen "a != b" into "a < b" upon dropping the word "symmetry_breaking_constraint" in line 13 (but not its constraint)!
constraint symmetry_breaking_constraint(forall(w in Weeks, g in Groups)(strictly_increasing(Player[w,g,..]))); % slot symmetry
output [show(Player[w,g,..]) ++ if g = nGroups then "\n" else " " endif | w in Weeks, g in Groups];
%% Local-search-friendly model of course 1DL481:
%array[Weeks,Players] of var Groups: Group; % Group[p,w] = the group of player p in week w
%constraint forall(w in Weeks)(global_cardinality_closed(Group[w,..], Groups, [nSlots | g in Groups])); % each week: each group has exactly nSlots players
%constraint forall(p1,p2 in Players where p1 < p2)(sum(w in Weeks)(Group[w,p1] = Group[w,p2]) <= 1); % any two players meet at most once
%constraint symmetry_breaking_constraint(forall(w in Weeks)(value_precede_chain(Groups,Group[w,..]))); % each week: the first occurrences of group names are ordered
%output let {array[Weeks,Groups] of var set of Players: GroupW = array2d(Weeks,Groups,[{p | p in Players where Group[w2,p] = g2} | w2 in Weeks, g2 in Groups])} in [show2d(GroupW)];
solve satisfy;