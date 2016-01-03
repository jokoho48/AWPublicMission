/*
Author: SENSEI

Last modified: 11/2/2014

Description: set units of group on patrol

             returns nothing
__________________________________________________________________*/
private "_houseArray";
params [["_grp", grpNull, [objNull, grpNull]], ["_range", 100, [0]]];

if (typeName _grp isEqualTo "OBJECT") then {_grp = group _grp};
_grp setBehaviour "SAFE";
_lead = leader _grp;
_houseArray = (getposATL _lead) nearObjects ["house",_range];
if (count _houseArray > 0) then {
    [_grp, _range, _houseArray] call SEN_fnc_setPatrolUnit;
} else {
    [_grp, _range] call SEN_fnc_setPatrolUnit;
};
