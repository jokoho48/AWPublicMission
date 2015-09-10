/*
Author: SENSEI

Last modified: 7/28/2015

Description: runs when transport is disabled enroute

		NOTE: function must be spawned
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_requestor","_transport","_markers","_helipad","_pilot","_crew","_pilotArray"];

_requestor = _this select 0;
_transport = _this select 1;
_markers = _this select 2;
_helipad = _this select 3;

_pilot = driver _transport;
_crew = crew _transport;

while {(missionNameSpace getVariable ["SEN_transportReady", 0]) isEqualTo 0} do {
	if (!alive _pilot || {vehicle _pilot isEqualTo _pilot} || {isTouchingGround _transport && (!(canMove _transport) || (fuel _transport isEqualTo 0))}) exitWith {
		if (!isNull _helipad) then {deletevehicle _helipad};
		SEN_objectCleanup append _crew;
		SEN_objectCleanup pushBack _transport;
		deleteMarker (_markers select 0);
		deleteMarker (_markers select 1);
		if !(isNull _requestor) then {
			["Requested transport is disabled. Transport will be available shortly.","hintSilent",owner _requestor] call BIS_fnc_MP;
			["SEN_transportDestroyed","playSound",owner _requestor] call BIS_fnc_MP;
			//"Requested transport is disabled. Transport will be available shortly." remoteExecCall ["hintSilent", owner _requestor, false];
			//"SEN_transportDestroyed" remoteExecCall ["playSound", owner _requestor, false];

		};
		uiSleep 300;
		missionNameSpace setVariable ["SEN_transportReady", 1];
	};
	uiSleep 5;
};