% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
int: n; constraint assert(n >= 2 /\ n mod 2 = 0, "Odd n"); % number of teams; n=4 is unsatisfiable; search annotation requires n!=2
set of int: Teams = 1..n;
set of int: Weeks = 1..(n-1);
set of int: Periods = 1..(n div 2);
set of int: GameIds = {f * n + s | f,s in Teams where f != s}; % note that both "f vs s" and "s vs f" have ids, and distinct ones
function var GameIds: encode(var Teams: f, var Teams: s) = f * n + s; % encode the game "f vs s" into a game identifier; assume f!=s
function tuple(Teams,Teams): decode(GameIds: g) = ((g - 1) div n, (g - 1) mod n + 1); % decode a game identifier into its teams f and s
array[Weeks] of var set of GameIds: Games; % Games[w] = the set of games to be played in week w; enforces: (1) each possible game is played exactly once; precomputed during flattening via the following 2 constraints:
constraint Games[1] = {encode(1,2)} union {encode(t+1,n+2-t) | t in 2..(n div 2)}; % precomputation: base case
constraint forall(w in 2..(n-1))(Games[w] = {let {tuple(Teams,Teams): fs = decode(g)} in encode(if fs.1 = 1 then 1 else if fs.1 = n then 2 else fs.1 + 1 endif endif, if fs.2 = n then 2 else fs.2 + 1 endif) | g in Games[w-1]}); % precomputation: step case
array[Periods,Weeks,1..2] of var Teams: Team; % Team[p,w,s] = the team that plays in period p of week w in game slot s
array[Periods,Weeks]    of var GameIds: Game; % Game[p,w]   = the game played in period p of week w; mutually redundant with Team
%% Chose one of the following two lines for channelling:
constraint forall(p in Periods, w in Weeks)(encode(Team[p,w,1],Team[p,w,2]) = Game[p,w]) :: domain_propagation ; % two-way channelling: 1st alternative
%constraint forall(p in Periods, w in Weeks)(table([Team[p,w,1],Team[p,w,2],Game[p,w]], array2d(1..(n*(n-1)), 1..3, [[f,s,f*n+s][i] | f,s in Teams where f != s, i in 1..3]))); % two-way channelling: 2nd alternative
constraint forall(p in Periods, w in Weeks)(Game[p,w] in Games[w]); % for each week w: the games prescribed by Games[w] are played
constraint forall(w in Weeks)(all_different(Team[..,w,..])); % (2) each team plays exactly once per week
constraint forall(p in Periods)(global_cardinality_closed(Team[p,..,..], Teams, [1 | i in 1..n], [2 | i in 1..n])); % (3) each team plays at most twice per period
constraint symmetry_breaking_constraint(strictly_increasing([encode(Team[p,1,1],Team[p,1,2]) | p in Periods])); % the games of week 1 are ordered; ordering the games of period 1 leads to unsatisfiability (unlike in SSP1.mzn)
solve 
  :: seq_search([[int_search(Game[i,..],first_fail,indomain_min), int_search(Game[..,i],first_fail,indomain_min)][j] | i in 1..((n-4) div 2), j in 1..2] ++ [int_search(Game[(n div 2)-1,..],first_fail,indomain_min), int_search(Game[n div 2,..],first_fail,indomain_min)]) % requires n >= 4
  satisfy;
output [if w = n then "\n" else "\(Team[p,w,1]) vs \(Team[p,w,2])   " endif | p in Periods, w in 1..n];