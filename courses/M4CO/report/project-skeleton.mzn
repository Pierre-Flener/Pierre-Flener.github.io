%%% Team ..., UU, course 1DL451, Project, year 20...

include "globals.mzn";

%% Parameters:
...; % ... meaning ... (for example: X[i,j] = ... i ... j ...)

%% Derived parameters:
...; % ... meaning ... (for example: X[i,j] = ... i ... j ...)
% None

%% Decision variables:
...; % ... meaning ... (for example: X[i,j] = ... i ... j ...)
% Problem constraints enforced by this choice of variables:
% ... paraphrase ...
% No problem constraints are enforced by this choice of variables.

%% Redundant decision variables:
...; % ... meaning ...; (non-)mutually redundant with ...
% None, because ...

%% Channelling constraints:
constraint ...; % 1-way from ... to ... / 2-way between ... and ...
% None, because ...

%% Problem constraints:
constraint ...; % ... paraphrase ...

%% Implied constraints:
constraint implied_constraint(...); % ... paraphrase ...
% None.

%% Symmetry-breaking constraints:
constraint symmetry_breaking_constraint(...); % ... paraphrase ...
% None.

solve
  %% Search strategy:
  % ... paraphrase ...:
  :: ..._search(...)
  %% Objective and objective function:
  % ... paraphrase ...:
  minimize ... | maximize ... | satisfy;

%% Pretty-print solutions:
output [...];