/*
Author: SENSEI

Last modified: 8/14/2015

Description:  deploy FOB
__________________________________________________________________*/
private ["_pos","_anim","_t","_key"];

_pos = player modelToWorld [0,3,0];
_pos set [2,0];

if ([_pos,"SEN_safezone_mrk"] call SEN_fnc_checkInMarker) exitWith {
	hintSilent "Unsuitable position for FOB. Select an area away from MOB Dodge.";
};

if (count (_pos isFlatEmpty [1, 0, 0.5, 15, 0, false, player]) isEqualTo 0) exitWith {
	hintSilent "Unsuitable position for FOB. Select a flat open area.";
};

player setVariable ["SEN_inProgress",true];
hintSilent "Deploying FOB Pirelli...";
_anim = animationState player;
_t = time + 8;
player playMove "AinvPknlMstpSnonWnonDr_medicUp1";
player playMove _anim;
waitUntil {sleep 0.1; (animationState player isEqualTo _anim) || (time isEqualTo _t)};
[[player,_pos,100],"SEN_fnc_fobSetup",false,false] call BIS_fnc_MP;
player addEventHandler ["respawn",{
	[] spawn {
		sleep 5;
		if ((getPlayerUID player) isEqualTo SEN_curatorFOBUnitUID) then {[[[player],{(_this select 0) assignCurator SEN_curatorFOB}],"BIS_fnc_spawn",false,false] call BIS_fnc_MP};
	};
}];
_key = (actionKeys "curatorInterface") select 0;
if (!isNil "_key") then {hint format ["Press the Zeus key, %1, to construct FOB Pirelli.",keyName _key]} else {hint format ["Press the Zeus key, %1, to construct FOB Pirelli.",'UNBOUND']};
player setVariable ["SEN_inProgress",false];