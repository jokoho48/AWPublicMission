/*
Author: SENSEI

Last modified: 8/15/2015

Description: spawns suicide bomber

			 returns nothing
__________________________________________________________________*/
private ["_unit","_range","_dist","_grp","_targets","_targetPlayer"];

_unit = _this select 0;
_range = _this select 1;
_dist = 20;
_grp = [[_unit]] call SEN_fnc_setSide;
_unit = leader _grp;
_unit forceSpeed (_unit getSpeed "FAST");
_unit allowfleeing 0;
_targets = [(getPosATL _unit),_range] call SEN_fnc_getNearPlayers;
if (count _targets isEqualTo 0) exitWith {[1,"No players near bomber."] call SEN_fnc_log};
_targetPlayer = _targets select (random ((count _targets) - 1));
[0,"Bomber target is %1.",name _targetPlayer] call SEN_fnc_log;
_unit addVest "V_TacVestIR_blk";
_unit addEventHandler ["Hit", {"HelicopterExploSmall" createVehicle ((_this select 0) modeltoworld [0,0,0]); (_this select 0) removeAllEventHandlers "Hit"}];

[_unit,_targetPlayer,_dist] spawn {
	_unit = vehicle (_this select 0);
	_targetPlayer = _this select 1;
	_dist = _this select 2;
	while {alive (driver _unit)} do {
		if ((_targetPlayer distance _unit) < (_dist*6 min 100)) then {
			playSound3D ["A3\Sounds_F\sfx\Beep_Target.wss", _unit, false, getPosATL _unit, 1, 1, 200];
		};
		sleep (((_targetPlayer distance _unit)*0.005 max 0.1) min 1);
	};
};

[_unit,_targetPlayer,_dist] spawn {
	_unit = _this select 0;
	_targetPlayer = _this select 1;
	_dist = _this select 2;
	while {alive _unit} do {
		uiSleep 8;
		_unit doMove (getposatl _targetPlayer);
		if (_unit distance _targetPlayer < _dist) exitWith {
			"HelicopterExploSmall" createVehicle (_unit modeltoworld [0,0,0]);
			deleteVehicle _unit;
			[0,"Bomber detonation."] call SEN_fnc_log;
		};
		if (_unit distance _targetPlayer > 1000) exitWith {
			deleteVehicle _unit;
			[0,"Bomber is too far from target. Deleting bomber."] call SEN_fnc_log;
		};
	};
	deleteVehicle _unit;
};