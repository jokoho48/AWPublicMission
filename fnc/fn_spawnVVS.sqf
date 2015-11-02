/*
Author: SENSEI, Tonic

Last modified: 8/13/2015

Description: spawns vehicle for VVS

        returns nothing
__________________________________________________________________*/
if !(isServer) exitWith {};

private ["_cfgInfo","_vehicle"];

params [["_className", "", [""]], ["_position", [0, 0, 0], [[]]], ["_direction", 0, [0]]];

if (0 != count (nearestObjects [_position,["landVehicle","Air","Ship","ReammoBox_F"],(7 max (ceil(sizeOf _className)))])) exitWith {
    hint format ["Fail to spawn %1, not Enoth space.", _className];
};

_cfgInfo = [_className] call VVS_fnc_cfgInfo;

_vehicleType = _cfgInfo select 4;

_index = [JK_VehicleTickets, _vehicleType] call BIS_fnc_findInPairs;
if (_index == -1) then {_index = [JK_VehicleTickets, "Default"] call BIS_fnc_findInPairs;};

_costs = (JK_VehicleTickets select _index) select 1;
if (isNil "_costs") then {
    _costs = 200;
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

if(_vehicleType isEqualTo "Autonomous") then {
    createVehicleCrew _vehicle;
};

if(VVS_Checkbox) then {
    clearWeaponCargoGlobal _vehicle;
    clearMagazineCargoGlobal _vehicle;
    clearItemCargoGlobal _vehicle;
};

uiSleep 5;

_vehicle allowDamage true;
