/*
Author: SENSEI, Tonic

Last modified: 8/13/2015

Description: spawns vehicle for VVS

		returns nothing
__________________________________________________________________*/
if !(isServer) exitWith {};

private ["_className","_position","_direction","_cfgInfo","_vehicle"];

_className = param [0,"",[""]];
_position = param [1,[0,0,0],[[]]];
_direction = param [2,0,[0]];

{deleteVehicle _x} count (nearestObjects [_position,["landVehicle","Air","Ship","ReammoBox_F"],(7 max (ceil(sizeOf _className)))]);
uiSleep 0.1;
_position set [2,0.5];
_cfgInfo = [_className] call VVS_fnc_cfgInfo;
_vehicle = _className createVehicle _position;
_vehicle allowDamage false;
_vehicle setDir _direction;
if !(surfaceIsWater _position) then {_vehicle setPosATL _position} else {_vehicle setPosASL _position};
_vehicle setVectorUp [0,0,1];

if((_cfgInfo select 4) isEqualTo "Autonomous") then {
	createVehicleCrew _vehicle;
};

if(VVS_Checkbox) then {
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
};

uiSleep 5;

_vehicle allowDamage true;