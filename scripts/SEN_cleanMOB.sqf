/*
Author: SENSEI

Last modified: 11/20/2014

Description:  deletes empty vehicles and bodies at MOB
__________________________________________________________________*/
_mrkPos = (getmarkerpos "SEN_safezone_mrk");
_range = ((getmarkersize "SEN_safezone_mrk") select 0);
_vehArray = nearestObjects [_mrkPos,["landVehicle","Air","Ship","ReammoBox_F"],_range];

{
    if ((count (crew _x)) isEqualTo 0 && {!(_x getVariable ["SEN_noClean", false])}) then {deleteVehicle _x};
} forEach _vehArray;

{
    if (getposATL _x distance _mrkPos <= _range) then {deleteVehicle _x};
} forEach allDead;
