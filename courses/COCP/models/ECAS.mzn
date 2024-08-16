% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
enum Resources; % reusable resources
int: nMachines; % number of machines
set of int: Machines = 1..nMachines;
array[Machines] of int: IdlePower;  %% not used in the core model below
array[Machines] of int: UpCost;     %% not used in the core model below
array[Machines] of int: DownCost;   %% not used in the core model below
array[Machines,Resources] of int: Capacity; % Capacity[m,r] = the capacity of resource r on machine m
int: nTimeSteps; % number of time steps
set of int: Times = 0..nTimeSteps; % time points
set of int: Steps = 1..nTimeSteps; % time step s is the interval from time point s-1 to time point s
array[Steps] of float: EnergyCost; % EnergyCost[s] = the cost of energy, in €/kWh, during time step s
int: nJobs; % number of jobs
set of int: Jobs = 1..nJobs;
array[Jobs] of Steps: Duration;  % job j lasts Duration[j] time steps
array[Jobs] of Times: EarliestS; % job j starts at or after time point EarliestS[j]
array[Jobs] of Times: LatestEnd; % job j ends  at or before time point LatestEnd[j]
array[Jobs] of int: Energy;      % job j consumes Energy[j] kWh
array[Jobs,Resources] of int: Requirement; % Requirement[j,r] = the requirement for resource r by job j
array[Jobs] of var Times:    Start;   % Start[j] = the start time of job j
array[Jobs] of var Machines: Machine; % Machine[j] = the machine of job j
constraint forall(j in Jobs)(Start[j] in EarliestS[j]..LatestEnd[j]-Duration[j]); % (1) no job starts too early or ends too late
constraint forall(m in Machines, r in Resources)(cumulative(Start, Duration, [(Machine[j]=m)*Requirement[j,r] | j in Jobs], Capacity[m,r])); % (2) no resource capacity of any machine is ever exceeded
%% ... state here the other constraints of the problem ...
array[Jobs] of var 0..floor(max(Energy)*sum(EnergyCost)): Cost; % Cost[j] = the energy cost of job j
%%% WITHOUT PRECOMPUTATION:
% constraint forall(j in Jobs)
%   (Cost[j] = sum(s in Steps)
% %   (if s in (Start[j]+1)..(Start[j]+Duration[j])  %% introduces set variables under Gecode
%     (if Start[j]+1 <= s /\ s <= Start[j]+Duration[j]
%      then floor(Energy[j]*EnergyCost[s]) else 0 endif));  %% we must round each term of the sum, instead of rounding the sum, as in the precomputation below!
%%% WITH PRECOMPUTATION:
% JobCost[j,t] = energy cost of job j if j starts at time t, with dummy values if t+Duration[j] > nTimeSteps:
array[Jobs,Times] of int: JobCost = array2d(Jobs,Times,[floor(Energy[j]*sum(EnergyCost[t+1..min(t+Duration[j],nTimeSteps)])) | j in Jobs, t in Times]); % round the sum, not its terms!
constraint forall(j in Jobs)(Cost[j] = JobCost[j,Start[j]]);
solve
  :: seq_search([
       int_search(Machine, first_fail, indomain_min),
       int_search(Start, smallest, indomain_split)
     ])
% minimize sum(Cost); %% + ... add here the other costs
  satisfy;
%output [show(sum(Cost))];
%output ["JobCost = \(JobCost) \n"];

%%% WITH PRECOMPUTATION: first solution, of cost 285120 (corresponding to 282653 without precomputation, due to flooring entire float sums here):
% Start = array1d(1..100, [4, 54, 37, 263, 194, 222, 35, 129, 3, 229, 36, 57, 191, 76, 34, 275, 79, 171, 216, 255, 188, 40, 55, 79, 136, 147, 89, 201, 46, 208, 141, 193, 150, 177, 138, 20, 210, 206, 209, 91, 188, 266, 35, 5, 208, 38, 276, 197, 234, 176, 188, 212, 265, 180, 35, 246, 182, 179, 230, 255, 237, 5, 60, 7, 77, 196, 169, 161, 231, 150, 11, 4, 163, 211, 220, 243, 145, 74, 9, 269, 274, 238, 65, 241, 145, 33, 17, 197, 36, 179, 27, 20, 10, 148, 219, 12, 35, 40, 131, 179]);
% Machine = array1d(1..100, [1, 1, 1, 2, 2, 2, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 1, 2, 1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 2, 2, 2, 1, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 2, 2, 2, 2, 1, 2, 2, 1, 1, 2, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 2, 1, 1, 1]);
%%% WITHOUT PRECOMPUTATION: first solution, of cost 285663 (corresponding to 288217 with precomputation, due to flooring float terms of sums here):
% Start = array1d(1..100, [258, 65, 6, 98, 104, 150, 0, 147, 0, 188, 2, 37, 204, 23, 35, 275, 56, 179, 203, 256, 259, 23, 74, 112, 136, 147, 127, 184, 13, 244, 132, 193, 153, 138, 139, 17, 8, 228, 209, 106, 239, 254, 20, 11, 208, 101, 270, 233, 17, 121, 186, 78, 257, 104, 2, 246, 190, 182, 230, 187, 202, 3, 19, 104, 136, 183, 79, 118, 42, 191, 17, 83, 163, 232, 220, 234, 110, 113, 33, 162, 274, 233, 80, 222, 137, 23, 44, 8, 9, 179, 38, 29, 0, 162, 163, 6, 8, 77, 83, 179]);
% Machine = array1d(1..100, [1, 2, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 2, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 1, 1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 2, 2, 1, 2, 2, 2, 2, 1, 1, 2, 1, 2, 2, 2, 2, 1, 2, 2, 1, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 2, 1, 1, 2, 2, 2, 1, 2]);