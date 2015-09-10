/*
Author: SENSEI

Last modified: 1/7/2015

Description: convoy task

		NOTE: on hold until AI driving is better
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_townStart","_townEnd","_type1","_type2","_type3"];

if (count SEN_whitelistLocation < 2) exitWith {SEN_taskCounter = SEN_taskCounter - 1; [] call SEN_fnc_setTask;};

_counter = 0;
_minDist = SEN_range/4;
_speed = 40;
_vehArray = [];

if (SEN_enemySide isEqualTo EAST) then {
	_type1 = "O_Truck_03_transport_F";
	_type2 = "O_MRAP_02_hmg_F";
	_type3 = "O_MRAP_02_F";
} else {
	_type1 = "I_Truck_02_transport_F";
	_type2 = "I_MRAP_03_hmg_F";
	_type3 = "I_MRAP_03_F";
};

for "_i" from 0 to 9 do {
	_townArray = SEN_whitelistLocation;
	_townStart = _townArray select (random ((count _townArray) - 1));
	_townArray = _townArray - [_townStart];
	_townEnd = _townArray select (random ((count _townArray) - 1));

	if ((({_x distance getpos _townStart < 1000} count (call SEN_fnc_getPlayers)) isEqualTo 0) && {getpos _townStart distance getpos _townEnd > _minDist}) exitWith {};

	if (_i isEqualTo 9) exitWith {
		_townStart = _townArray select (random ((count _townArray) - 1));
		_townArray = _townArray - [_townStart];
		_townEnd = _townArray select (random ((count _townArray) - 1));
	};
	sleep 0.1;
};

_pos1 = [getpos _townStart, 100, 500, 10, 0, 0.4, 0] call BIS_fnc_findSafePos;
_grp = createGroup SEN_enemySide;

_device = "Land_Device_assembled_F" createVehicle _pos1;
_device enableSimulationGlobal false;
_vehArray pushBack _device;

_rand = [_type2,_type3] select (random ((count [_type2,_type3]) - 1));
_veh = [[_pos1, 5, 15, 5, 0, 1, 0] call BIS_fnc_findSafePos, 0, _rand, _grp] call BIS_fnc_spawnVehicle;
_veh = _veh select 0;
_veh limitSpeed _speed;
_vehArray pushBack _veh;

_rand = [_type2,_type3] select (random ((count [_type2,_type3]) - 1));
_veh = [[_pos1, 5, 15, 5, 0, 1, 0] call BIS_fnc_findSafePos, 0, _rand, _grp] call BIS_fnc_spawnVehicle;
_veh = _veh select 0;
_veh limitSpeed _speed;
_vehArray pushBack _veh;

_veh = [[_pos1, 5, 15, 5, 0, 1, 0] call BIS_fnc_findSafePos, 0, _type1, _grp] call BIS_fnc_spawnVehicle;
_transport = _veh select 0;
_transport limitSpeed _speed;
_vehArray pushBack _transport;

_device attachTo [_transport,[0,-2.6,0]];

_grp setBehaviour "SAFE";
_grp move getpos _townEnd;

_mrk = createMarker ["SEN_convoy_end",getpos _townEnd];
_mrk setMarkerColor "ColorEAST";
_mrk setMarkerType "mil_end";
_mrk setMarkerText "Convoy Destination";

_mrk = createMarker ["SEN_convoy_AO",[getpos _transport,50,350] call SEN_fnc_findRandomPos];
_mrk setMarkerColor "ColorEAST";
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerAlpha 0.7;
_mrk setMarkerSize [500,500];

[_mrk,_transport] spawn {
	while {(getmarkercolor (_this select 0) != "")} do {
		(_this select 0) setMarkerPos ([getpos (_this select 1),50,350] call SEN_fnc_findRandomPos);
		sleep 10;
	};
};

[["convoy_01", "",
"Capture Advanced Tech and Deliver to MOB Dodge", "assigned"]] call FHQ_TT_addTasks;

waitUntil {sleep 10; _transport distance getpos _townEnd < 50; damage _device > 0.9; {isPlayer _x} count (crew _transport) > 0};

if ({isPlayer _x} count (crew _transport) > 0) then {
	_server = owner (missionnamespace getvariable ["bis_functions_mainscope",objnull]);
	deleteMarker _mrk;

	if (random 1 < .5) then {
		_end = getmarkerPos "SEN_depotSpawn_mrk";
		_dist = (_transport distance _end)/2;

		waitUntil {sleep 10; _transport distance _end < _dist};

		if !((owner _transport) isEqualTo _server) then {
			createVehicle ["R_TBG32V_F", _transport modeltoworld [(-5 + random 10),(25 + random 8),-3],[],0,"CAN_COLLIDE"];
			sleep 1;
			createVehicle ["R_TBG32V_F", _transport modeltoworld [(-5 + random 10),(13 + random 5),-3],[],0,"CAN_COLLIDE"];
			[[_transport,["motor",1]],"setHit",owner _transport] call BIS_fnc_MP;
		} else {
			createVehicle ["R_TBG32V_F", _transport modeltoworld [(-5 + random 10),(25 + random 8),-3],[],0,"CAN_COLLIDE"];
			sleep 1;
			createVehicle ["R_TBG32V_F", _transport modeltoworld [(-5 + random 10),(13 + random 5),-3],[],0,"CAN_COLLIDE"];
			_transport setHit ["motor", 1];
		};

		_pos2 = [getpos _transport,300,400,1,0,1,0] call BIS_fnc_findSafePos;
		_grp = [_pos2,0,8] call SEN_fnc_spawnGroup;
		[_grp,getpos _transport] call bis_fnc_taskAttack;
	};

	waitUntil {sleep 10; _transport distance _end < 25; damage _device > 0.9};

	if (damage _device > 0.9) exitWith {
		["convoy_01", "failed"] call FHQ_TT_setTaskState;
		SEN_objectCleanup append _vehArray;
		[] call SEN_fnc_setTask;
	};

	["convoy_01", "succeeded"] call FHQ_TT_setTaskState;
	SEN_objectCleanup append _vehArray;
	[] call SEN_fnc_setTask;
} else {
	["convoy_01", "failed"] call FHQ_TT_setTaskState;
	SEN_objectCleanup append _vehArray;
	[] call SEN_fnc_setTask;
};