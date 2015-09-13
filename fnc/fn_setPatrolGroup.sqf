/*
Author: SENSEI

Last modified: 11/2/2014

Description: set units of group on patrol

             returns nothing
__________________________________________________________________*/
private "_houseArray";
params [["_grp", grpNull, [objNull, grpNull]], ["_range", 100, [0]]]

if (typeName _grp isEqualTo "OBJECT") then {_grp = group _grp};
_grp setBehaviour "SAFE";
_lead = leader _grp;
_unitArray = units _grp;
_houseArray = (getposATL _lead) nearObjects ["house",_range];
/*[0,"fn_setPatrolGroup: group leader: %1, house array: %2.",_lead, _houseArray] call SEN_fnc_log;*/

if (count _houseArray > 0) then {
    {
    //_x setVariable ["SEN_patrol_exit",false];
        [_x,_range,_houseArray] spawn SEN_fnc_setPatrolUnit;
    } forEach _unitArray;
} else {
    {
    //_x setVariable ["SEN_patrol_exit",false];
        [_x,_range] spawn SEN_fnc_setPatrolUnit;
    } forEach _unitArray;
};
