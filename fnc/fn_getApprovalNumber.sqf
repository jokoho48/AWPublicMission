/*
Author: SENSEI

Last modified: 7/17/2015

Description: calculates number based on approval

        returns number
__________________________________________________________________*/
private ["_min","_max","_chanceAtZeroApproval","_multiplier","_chance"];
params [["_min", 5.0, [0]], ["_max", 50, [0]], ["_chanceAtZeroApproval", 25.0, [0] ], ["_multiplier", 0.15, [0]]];

_chance = round (_chanceAtZeroApproval - (_multiplier*SEN_approvalCiv)) min _max;
_chance = _chance max _min;

_chance
