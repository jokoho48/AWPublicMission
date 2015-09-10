/*
Author: SENSEI

Last modified: 8/15/2015

Description:
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_town","_mrk","_pos","_townName","_townType","_radius","_approval","_enemyArray","_threshold","_t","_players","_hint","_mrkOfficer"];

_town = (_this select 0);
_mrk = _this select 1;

_town = call compile (_town);
_pos = getpos _town;
_pos set [2,0];
_townName = text _town;
_townType = type _town;
_radius = ((((size _town) select 0) + ((size _town) select 1))/2) + 100;
_approval = 0;
_enemyArray = [];

[0,"OccupyTrgAct: %1",_town] call SEN_fnc_log;
[0,"OccupyTrgAct: %1",_pos] call SEN_fnc_log;
[0,"OccupyTrgAct: %1",_townName] call SEN_fnc_log;
[0,"OccupyTrgAct: %1",_townType] call SEN_fnc_log;
[0,"OccupyTrgAct: %1",_radius] call SEN_fnc_log;

call {
    if (_townType isEqualTo "NameCityCapital") exitWith {_townType = "Capital"; _approval = 100};
    if (_townType isEqualTo "NameCity") exitWith {_townType = "City"; _approval = 75};
    _townType = "Town"; _approval = 50;
};

{
    if (side _x isEqualTo SEN_enemySide) then {_enemyArray pushBack _x};
} forEach (_pos nearEntities [["Man","LandVehicle","Air","Ship"], _radius]);
_threshold = round ((count _enemyArray)*0.30);

[0,"OccupyTrgAct: %1",_enemyArray] call SEN_fnc_log;
[0,"OccupyTrgAct: %1",_threshold] call SEN_fnc_log;

waitUntil {sleep 10; {alive _x} count _enemyArray <= _threshold};

_t = time;
_players = (call SEN_fnc_getPlayers);

if (count _players > 0) then {
    _hint = format ["The enemy is losing control of %1! Keep up the fight and they will surrender!",_townName];
    [_hint,"hintSilent",_players] call BIS_fnc_MP;
};

uiSleep 60;

{ // check for new units in area
    if (side _x isEqualTo SEN_enemySide) then {_enemyArray pushBack _x};
} forEach (_pos nearEntities [["Man","LandVehicle","Air","Ship"], _radius]);

if (count _enemyArray > 0) then {
    {
        call {
            if (typeOf _x isKindOf "AIR") exitWith {
                _x setBehaviour "CARELESS";
                SEN_objectCleanup pushBack _x;
            };
            if !(local _x) exitWith {
                [[_x],"SEN_fnc_setUnitSurrender",owner _x] call BIS_fnc_MP;
                if !(_x isEqualTo SEN_intelObj) then {SEN_objectCleanup pushBack _x};
            };
            [_x] call SEN_fnc_setUnitSurrender;
            if !(_x isEqualTo SEN_intelObj) then {SEN_objectCleanup pushBack _x};
        };
    } forEach _enemyArray;
};

_players = (call SEN_fnc_getPlayers);
if (count _players > 0) then {
    [["SEN_liberate",[_townName]],"BIS_fnc_showNotification",_players] call BIS_fnc_MP;
};
_mrk setMarkerText format ["Liberated %1",_townType];
_mrk setMarkerColor "ColorWEST";
SEN_approvalCiv = SEN_approvalCiv + _approval; publicVariable "SEN_approvalCiv";
if (SEN_debug isEqualTo 1) then {(format["SEN_occupy_AO_%1",_townName]) setMarkerColor "ColorWEST"};

uiSleep 10;

if (random 1 < 0.25) then {[_pos,SEN_enemySide,_radius+200] spawn SEN_fnc_spawnReinforcements};

if !(isNull SEN_intelObj) then {
    if (getposATL SEN_intelObj distance _pos < _radius) then {
        _hint = format ["Aerial reconnaissance shows the enemy officer is somewhere in %1.",_townName];
        [_hint,"hintSilent",_players] call BIS_fnc_MP;
        ["officer",getPosATL SEN_intelObj] call BIS_fnc_taskSetDestination;
    };
};

/*
[] spawn {
    _a = [];
    _town = (SEN_occupiedLocation select 0);
    _townPos = getpos _town;
    _townPos set [2,0];
    _radius = ((((size _town) select 0) + ((size _town) select 1))/2) + 100;
    player setpos _townPos;
    player allowDamage false;
    sleep 10;
    {
        if (side _x isEqualTo SEN_enemySide) then {_a pushBack _x};
    } forEach (_townPos nearEntities [["Man","Car","Tank","Air","Ship"], _radius]);
    _threshold = (round ((count _a)*0.30));
    _kill = (count _a) - _threshold;
    for "_i" from 0 to _kill do {
        (_a select _i) setDamage 1;
    };
};
*/
