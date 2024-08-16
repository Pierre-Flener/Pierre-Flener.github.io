% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
int: n; constraint assert(n >= 2 /\ n mod 2 = 0, "Odd n"); % number of teams; n=4 is unsatisfiable
set of int: Teams = 1..n;
set of int: Weeks = 1..(n-1);
set of int: ExtendedWeeks = 1..n; % week n is a dummy week
set of int: Periods = 1..(n div 2);
enum Slots = {one, two};
set of int: Games = {f * n + s | f,s in Teams where f < s};
array[Periods,ExtendedWeeks,Slots] of var Teams: Team; % Team[p,w,s] = the team that plays in period p of week w in game slot s
array[Periods,        Weeks      ] of var Games: Game; % Game[p,w]   = the game played in period p of week w; mutually redundant with Team
%% Chose one of the following two lines for channelling:
constraint forall(p in Periods, w in Weeks)(Team[p,w,one] * n + Team[p,w,two] = Game[p,w]) :: domain_propagation ; % two-way channelling: 1st alternative
% constraint forall(p in Periods, w in Weeks)(table([Team[p,w,one],Team[p,w,two],Game[p,w]], array2d(1..(n*(n-1) div 2), 1..3, [[f,s,f*n+s][i] | f,s in Teams where f < s, i in 1..3]))); % two-way channelling: 2nd alternative
constraint all_different(Game); % (1) each possible game is played exactly once
constraint forall(w in ExtendedWeeks)(all_different(Team[..,w,..])); % (2) each team plays exactly once per week, including the dummy one
constraint forall(p in Periods)(global_cardinality_closed(Team[p,..,..], Teams, [2 | i in 1..n])); % (3') each team plays exactly twice per period over the extended weeks
constraint symmetry_breaking_constraint(strictly_increasing(Game[..,1]) /\ strictly_increasing(Game[1,..])); % logical simplification of lex2, due to the all_different for (1)
solve :: int_search(Game,first_fail,indomain_min) satisfy;
output [if w = n then "\n" else "\(Team[p,w,one]) vs \(Team[p,w,two])   " endif | p in Periods, w in ExtendedWeeks];