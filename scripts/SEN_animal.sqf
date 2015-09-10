/*
Author: SENSEI

Last modified: 2/3/2015

Description: handles animal functionality
__________________________________________________________________*/
_dist = _this select 0;
_count = _this select 1;

_counter = 0;
_posArray = [];
_expArray = [["(1 - forest) * (1 + meadow) * (1 - sea) * (1 - houses) * (1 - hills)","meadow"],["(1 + forest + trees) * (1 - sea) * (1 - houses)","forest"],["(1 - forest) * (1 + hills) * (1 - sea)","hills"]];

while {_counter < _count} do {
	_selected = _expArray select (random ((count _expArray) - 1));
	_expression = _selected select 0;
	_str = _selected select 1;
	_pos = [SEN_centerPos,0,SEN_range] call SEN_fnc_findRandomPos;
	_ret = selectBestPlaces [_pos,1000,_expression,80,1];
	if (!(count _ret isEqualTo 0) && {!([_ret select 0 select 0, "SEN_safezone_mrk"] call SEN_fnc_checkInMarker)} && {!(surfaceIsWater(_ret select 0 select 0))} && {{((_ret select 0 select 0) distance (_x select 0)) < _dist} count _posArray isEqualTo 0}) then {
		_posArray pushBack [_ret select 0 select 0,_str];
		_counter = _counter + 1;
	};
	uiSleep 0.1;
};

if (count _posArray isEqualTo 0) exitWith {[2,"SEN_animal.sqf, position array is empty."] call SEN_fnc_log};

{
	_pos = _x select 0;
	_str = _x select 1;

	_trg = createTrigger ["EmptyDetector",_pos];
	_trg setTriggerArea [_dist,_dist,0,FALSE];
	_trg setTriggerActivation ["ANY","PRESENT",true];
	_trg setTriggerTimeout [5, 5, 5, true];

	_cond = format["{(isplayer _x && {getposATL (vehicle _x) distance %1 < %2} && {((getposATL _x) select 2) < 30})} count playableunits > 0",(getposATL _trg),_dist];
	_trgVar = format ["SEN_%1_animal_trg", _pos];
	_trgAct = format ["[%1,%2,%3,%4] spawn SEN_fnc_spawnAnimal;",_pos,str _str,round(10+random 10),str _trgVar];
	_trgDe = format ["missionNameSpace setvariable [%1,false]",str _trgVar];
	_trg setTriggerStatements [_cond,_trgAct,_trgDe];

	if (SEN_debug isEqualTo 1) then {
		[0,"Creating animal trigger: Position: %1, Expression: %2.", _pos,_str] call SEN_fnc_log;
		_mrk = createMarker [format["%1_DEBUG",_trgVar],getposATL _trg];
		_mrk setMarkerColor "ColorGreen";
		_mrk setMarkerShape "ELLIPSE";
		_mrk setMarkerText _str;
		_mrk setMarkerAlpha 0.5;
		_mrk setMarkerSize [_dist,_dist];
		_mrk = createMarker [format["%1_2_DEBUG",_trgVar],getposATL _trg];
		_mrk setMarkerType "mil_dot";
		_mrk setMarkerText _str;
		_mrk setMarkerAlpha 0.5;
	};
} forEach _posArray;