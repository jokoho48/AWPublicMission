/*
Author: SENSEI

Last modified: 7/28/2015

Description: handles transport functionality
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_package","_requestor","_type","_dirArray","_spawnPos","_transport","_bbr","_p1","_p2","_maxWidth","_maxLength","_maxHeight","_maxDeminsion","_pos","_pilot","_fobHeliPad","_isEmpty","_dir","_s","_sel","_crew","_hlz","_mrk","_helipad","_t"];

_package = _this select 0;
_requestor = _package select 0;
_type = _package select 1;
_dirArray = [];
_spawnPos = [0,0,0];
if !((missionNameSpace getVariable ["SEN_transportReady",0]) isEqualTo 1) exitWith {
	["Transport is not available.","hintSilent",owner _requestor] call BIS_fnc_MP;
};
missionNamespace setVariable ["SEN_transportResponse", nil];
missionNameSpace setVariable ["SEN_transportReady", 0];

_transport = _type createVehicle _spawnPos;
_transport allowDamage false;
sleep 0.2;
_bbr = boundingBoxReal _transport;
_p1 = _bbr select 0;
_p2 = _bbr select 1;
_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
_maxLength = abs ((_p2 select 1) - (_p1 select 1));
_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
_maxDeminsion = (ceil((_maxWidth max _maxLength) max _maxHeight))*0.60;
sleep 0.2;
deleteVehicle _transport;

[[_type,_maxDeminsion],"SEN_fnc_transportResponse",owner _requestor] call BIS_fnc_MP;

waitUntil {uiSleep 1; !isNil "SEN_transportResponse"};

_pos = missionnamespace getVariable ["SEN_transportResponse", []];
if (_pos isEqualTo []) exitWith {
	missionNameSpace setVariable ["SEN_transportReady", 1];
	deleteVehicle _transport;
};
// check if near FOB and has helipad
if !(getMarkerColor "sen_fob_mrk" isEqualTo "") then {
	if (_pos distance getMarkerPos "sen_fob_mrk" < 100) then {
		_fobHeliPad = (nearestObjects [_pos, ["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadEmpty_F","Land_HelipadRescue_F","Land_HelipadSquare_F","Land_JumpTarget_F"], 100]) select 0;
		if(!isNil "_fobHeliPad") then {
			_isEmpty = (getPosATL _fobHeliPad) isFlatEmpty [_maxDeminsion, 0, 0.6, _maxDeminsion, 0, false, _fobHeliPad];
			if (count _isEmpty > 0) then {_pos = getPosATL _fobHeliPad};
		};
	};
};

{
	_dir = ([_pos, getpos _x] call BIS_fnc_dirTo) + 180;
	_dirArray pushBack [_forEachIndex,(_dir - 30),(_dir + 30)];
} forEach SEN_occupiedLocation;

for "_s" from 1 to 20 do {
	_sel = (_dirArray select (random ((count _dirArray) - 1))) select 0;
	_spawnPos = [_pos,5000,6000,_dirArray select _sel] call SEN_fnc_findRandomPos;
	{if (_spawnPos distance (getpos _x) < (SEN_range*0.2 max 2500)) exitWith {_spawnPos = [0,0,0]}} forEach SEN_occupiedLocation;
	if !(_spawnPos isEqualTo [0,0,0]) exitWith {diag_log "good pos"};
	uiSleep 0.1;
};
if (_spawnPos isEqualTo [0,0,0]) then {
	[1,"fn_transportHandler: Good spawn position not found."] call SEN_fnc_log;
	_spawnPos = [_pos,5000,6000] call SEN_fnc_findRandomPos;
};
_transport = createVehicle [_type,_spawnPos,[],0,"FLY"];
_pilot = createGroup WEST createUnit [(SEN_unitPoolWest select (random ((count SEN_unitPoolWest) - 1))),_spawnPos, [], 0, "NONE"];
_pilot moveInDriver _transport;
_pilot disableAI "TARGET";
_pilot disableAI "AUTOTARGET";
_pilot allowfleeing 0;
_pilot setBehaviour "CARELESS";
_transport enableCopilot false;
_transport flyInHeight 100;
_crew = crew _transport;

_hlz = createMarker [format["%1_hlz",_transport],_pos];
_hlz setMarkerType "mil_dot";
_hlz setMarkerColor "ColorWEST";
_hlz setMarkerText "TRANSPORT HLZ";
_hlz setmarkerAlpha 1;
_mrk = createMarker [format["%1_mrk",_transport],[0,0,0]];
_mrk setMarkerType "b_air";
_mrk setMarkerColor "ColorWEST";
//_mrk setMarkerAlpha 0;

_helipad = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];
["Transport enroute.","hintSilent",owner _requestor] call BIS_fnc_MP;
["SEN_transportAcknowledged","playSound",owner _requestor] call BIS_fnc_MP;
_transport doMove _pos;
[_mrk,_transport] spawn {
	while {(missionNameSpace getVariable ["SEN_transportReady",0]) isEqualTo 0} do {
		(_this select 0) setMarkerPos (getposATL (_this select 1));
		uiSleep 5;
	};
};
[_requestor,_transport,[_hlz,_mrk],_helipad] spawn SEN_fnc_transportDisabled;

waitUntil {uiSleep 1; (unitReady _pilot)};

_transport land "LAND";

waitUntil {uiSleep 1; (isTouchingGround _transport)};
/*
//workaround, sometimes transport lands then immediately moves into a hover
uiSleep 1;
if !(isTouchingGround _transport) then {_transport land "LAND"; waitUntil {uiSleep 1; (isTouchingGround _transport)};};*/
_t = time;
_transport engineOn true;
deleteVehicle _helipad;

waitUntil {uiSleep 1; ((_requestor in _transport) || time > (_t + 180))};

if !(_requestor in _transport) exitWith {
	["Requestor not in cargo. Transport returning to base.","hintSilent",owner _requestor] call BIS_fnc_MP;
	{if !(_x in _crew) then {moveOut _x}} count (crew _transport);
	_transport doMove [0,0,0];

	waitUntil {uiSleep 1; (count ([getposATL _transport,3000] call SEN_fnc_getNearPlayers) isEqualTo 0 || (_transport distance [0,0,100] < 500))};

	deleteMarker _hlz;
	deleteMarker _mrk;
	missionNameSpace setVariable ["SEN_transportReady", -1];
	uiSleep 5;
	deleteVehicle _pilot;
	deleteVehicle _transport;
	uiSleep 300;
	missionNameSpace setVariable ["SEN_transportReady", 1];
};

missionNamespace setVariable ["SEN_transportResponse", nil];
[[_type,_maxDeminsion],"SEN_fnc_transportResponse",owner _requestor] call BIS_fnc_MP;

waitUntil {uiSleep 1; !isNil "SEN_transportResponse"};

_pos = missionnamespace getVariable ["SEN_transportResponse", []];
if (_pos isEqualTo []) exitWith {
	{if !(_x in _crew) then {moveOut _x}} count (crew _transport);
	_transport doMove [0,0,0];

	waitUntil {uiSleep 1; (count ([getposATL _transport,3000] call SEN_fnc_getNearPlayers) isEqualTo 0 || (_transport distance [0,0,100] < 500))};

	deleteMarker _hlz;
	deleteMarker _mrk;
	missionNameSpace setVariable ["SEN_transportReady", -1];
	uiSleep 5;
	deleteVehicle _pilot;
	deleteVehicle _transport;
	uiSleep 300;
	missionNameSpace setVariable ["SEN_transportReady", 1];
};
// check if near FOB and has helipad
if !(getMarkerColor "sen_fob_mrk" isEqualTo "") then {
	if (_pos distance getMarkerPos "sen_fob_mrk" < 100) then {
		_fobHeliPad = (nearestObjects [_pos, ["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadEmpty_F","Land_HelipadRescue_F","Land_HelipadSquare_F","Land_JumpTarget_F"], 100]) select 0;
		if(!isNil "_fobHeliPad") then {
			_isEmpty = (getPosATL _fobHeliPad) isFlatEmpty [_maxDeminsion, 0, 0.6, _maxDeminsion, 0, false, _fobHeliPad];
			if (count _isEmpty > 0) then {_pos = getPosATL _fobHeliPad};
		};
	};
};
{if (isPlayer _x) then {["SEN_transportWelcome","playSound",owner _x] call BIS_fnc_MP}} forEach (crew _transport);
_hlz setMarkerPos _pos;
_transport doMove _pos;
_helipad = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];

waitUntil {uiSleep 1; (unitReady _pilot)};

_transport land "LAND";

waitUntil {uiSleep 1; (isTouchingGround _transport)};

/*//workaround, sometimes transport lands then immediately moves into a hover
uiSleep 1;
if !(isTouchingGround _transport) then {_transport land "LAND"; waitUntil {uiSleep 1; (isTouchingGround _transport)};};*/
deleteVehicle _helipad;
{if (isPlayer _x) then {["SEN_transportAccomplished","playSound",owner _x] call BIS_fnc_MP}} forEach (crew _transport);

waitUntil {uiSleep 1; (!(_requestor in _transport) || isNull _requestor)};

uiSleep 3;
{if !(_x in _crew) then {moveOut _x}} count (crew _transport);
_transport doMove [0,0,0];

waitUntil {uiSleep 1; (count ([getposATL _transport,3000] call SEN_fnc_getNearPlayers) isEqualTo 0 || (_transport distance [0,0,100] < 500))};

deleteMarker _hlz;
deleteMarker _mrk;
missionNameSpace setVariable ["SEN_transportReady", -1];
uiSleep 5;
{deleteVehicle _x} forEach _crew;
deleteVehicle _transport;
uiSleep 300;
missionNameSpace setVariable ["SEN_transportReady", 1];