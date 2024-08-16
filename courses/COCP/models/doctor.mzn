% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
set of int: Days; % d mod 7 = 1 iff d is a Monday
enum Doctors;
enum ShiftTypes = {appt, call, oper, none};
array[Doctors,Days] of var ShiftTypes: Roster; % Roster[i,j] = the shift type of Dr i on day j
constraint forall(d in Days)(count(Roster[..,d],call) = 1); % exactly 1 doctor on-call per day
constraint forall(d in Days where d mod 7 in 1..5)(count(Roster[..,d],oper) <= 2); % maximum 2 operating doctors per weekday
constraint forall(d in Days where d mod 7 in 6..7)(count(Roster[..,d],oper) =  0); %% not in the model on the slide, but satisfied by its solution
constraint count(Roster,oper) >= 7; % minimum 7 operating doctors per week
constraint count(Roster,appt) >= 4; % minimum 4 doctors on appointments per week
constraint forall(d in Doctors)(regular(Roster[d,..],"((oper none) | appt | call | none)*")); % day off after operation day
% ...  % other constraints
solve satisfy; % or optimise some objective function