/*
 *
 * Copyright: Pierre.Flener at it.uu.se and his TAs, 2024.
 *
 * This file is part of courses 1DL442 and 1DL451 at Uppsala
 * University in Sweden.
 *
 * Permission is hereby granted only to the registered students of
 * those courses to use this file, for a homework assignment.
 *
 * The copyright notice and permission notice above shall be
 * included in all copies and extensions of this file, and those
 * are not allowed to appear publicly on the internet, both during
 * a course instance and forever after.
 *
 */

%%% Team ..., UU, courses 1DL442 and 1DL451, Assignment 1 | Project, 2024
%%%
%%% Fill in for every "..." and delete all irrelevant text.
%%% In particular, delete the copyright notice for the Project.

include "globals.mzn";

%% Parameters:
...; % ... semantics ... (for example: X[i,j] = ... i ... j ...)

%% Derived parameters:
...; % ... semantics ...
% None

%% Decision variables:
...; % ... semantics ... (for example: X[i,j] = ... i ... j ...)
% Problem constraints enforced by this choice of variables:
% ...
% No problem constraints are enforced by this choice of variables.

%% Redundant decision variables:
...; % ... semantics ...; (non-)mutually redundant with ...
% None

%% Channelling constraints:
constraint ...; % 1-way from ... to ... / 2-way between ... and ...
% None

%% Problem constraints:
constraint ...; % ... semantics ...

%% Implied constraints:
constraint implied_constraint(...); % ... semantics ...
% None

%% Symmetry-breaking problem constraints:
constraint symmetry_breaking_constraint(...); % ... semantics ...
% None

solve
  %% Search strategy:
  % ... paraphrase ...:
  :: ..._search(...)
  %% Objective and objective function:
  % ... paraphrase ...:
  minimize ... | maximize ... | satisfy;

%% Pretty-print solutions:
output [...];