/*
Author: SENSEI, Tonic

Last modified: 8/13/2015

Description: spawns vehicle for VVS

        returns nothing
__________________________________________________________________*/
if !(isServer) exitWith {};

private "_vehicle";

params [["_className", "", [""]], ["_costs", 0,[0]], ["_position", [0, 0, 0], [[]]], ["_direction", 0, [0]]];

if (0 != count (nearestObjects [_position,["landVehicle","Air","Ship","ReammoBox_F"],(7 max (ceil(sizeOf _className)))])) exitWith {
    hint format ["Fail to spawn %1, not Enoth space.", _className];
};

JK_TicketSystem = JK_TicketSystem - _costs;
publicVariable "JK_TicketSystem";

uiSleep 0.1;
_position set [2,0.5];

_vehicle = _className createVehicle _position;

_vehicle allowDamage false;
_vehicle setDir _direction;
if !(surfaceIsWater _position) then {_vehicle setPosATL _position} else {_vehicle setPosASL _position};
_vehicle setVectorUp [0,0,1];
_vehicle setVariable ["JK_VSS_Cost", _costs];
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;

uiSleep 5;

_vehicle allowDamage true;
