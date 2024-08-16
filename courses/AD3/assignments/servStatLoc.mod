#
# Copyright: Pierre.Flener@it.uu.se and his teaching assistants, 2024.
#
# This file is part of course 1DL481 at Uppsala University, Sweden.
#
# Permission is hereby granted only to the registered students of that
# course to use this file, for a homework assignment.
#
# The copyright notice and permission notice above shall be included in
# all copies and extensions of this file, and those are not allowed to
# appear publicly on the internet, both during a course instance and
# forever after.
#

# Team:    ... # fill in your team number
# Authors: ... # fill in your names

param z; # number of zones
param s; # number of service stations
param v; # number of vehicles per service station
param c; # number of closest vehicles for average
set Zones := 1..z;
param Demand {Zones} >= 0; # Demand[i] = demand of zone i
param Time {Zones,Zones} >= 0; # Time[i,j] = time from zone i to j

