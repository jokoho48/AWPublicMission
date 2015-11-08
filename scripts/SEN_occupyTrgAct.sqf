/*
Author: SENSEI

Last modified: 8/15/2015

Description:
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_town","_mrk","_pos","_townName","_townType","_radius","_approval","_enemyArray","_threshold","_t","_players","_hint","_mrkOfficer", "_oldThreshold"];
params ["_town", "_mrk"];

_town = call compile (_town);
_pos = getpos _town;
_pos set [2,0];
_townName = text _town;
_townType = type _town;
_radius = ((((size _town) select 0) + ((size _town) select 1))/2) + 100;
_approval = 0;
_tickets = 0;
_enemyArray = [];

[0,"OccupyTrgAct: %1 %2 %3 %4 %5",_town, _pos, _townName, _townType, _radius] call SEN_fnc_log;

call {
    if (_townType isEqualTo "NameCityCapital") exitWith {_townType = "Capital"; _approval = 45; _tickets = 1000;};
    if (_townType isEqualTo "NameCity") exitWith {_townType = "City"; _approval = 30; _tickets = 800;};
    _townType = "Town"; _approval = 15; _tickets = 600;
};

_count = ({
    _ret = false;
    if (side _x isEqualTo SEN_enemySide) then {_enemyArray pushBack _x; _ret = true;};
    _ret
} count (_pos nearEntities [["Man","LandVehicle","Air","Ship"], _radius]));
_oldThreshold = round ((_count)*0.30);

waitUntil {
    private "_count";
    sleep 30;
    _count = 9999;
    _enemyArray = [];
    _count = ({
        _ret = false;
        if (side _x isEqualTo SEN_enemySide) then {_enemyArray pushBack _x; _ret = true;};
        _ret
    } count (_pos nearEntities [["Man","LandVehicle","Air","Ship"], _radius]));
    _threshold = (round ((_count)*0.30) max _oldThreshold);
    {alive _x} count _enemyArray <= _threshold
};

_t = time;
_players = (call SEN_fnc_getPlayers);

if (count _players > 0) then {
    _hint = format ["The enemy is losing control of %1! Keep up the fight and they will surrender!",_townName];
    [_hint,"hintSilent",_players] call BIS_fnc_MP;
};

uiSleep 60 + random 100;

{ // check for new units in area
    if (side _x isEqualTo SEN_enemySide) then {_enemyArray pushBack _x};
} forEach (_pos nearEntities [["Man","LandVehicle","Air","Ship"], _radius]);

if (count _enemyArray > 0) then {
    {
        call {
            if (random 1 < 0.2) then {
                if (typeOf _x isKindOf "AIR") exitWith {
                    _x setBehaviour "CARELESS";
                    _x land "LAND";
                    SEN_objectCleanup pushBack _x;
                };
                if !(local _x) then {

                    [[_x],"SEN_fnc_setUnitSurrender",owner _x] call BIS_fnc_MP;
                    if !(_x isEqualTo SEN_intelObj) then {SEN_objectCleanup pushBack _x};
                } else {
                    [_x] call SEN_fnc_setUnitSurrender;
                    if !(_x isEqualTo SEN_intelObj) then {SEN_objectCleanup pushBack _x};
                };
            };
        };
    } forEach _enemyArray;
};

_players = (call SEN_fnc_getPlayers);
if (count _players > 0) then {
    [["SEN_liberate",[_townName]],"BIS_fnc_showNotification",_players] call BIS_fnc_MP;
};
_mrk setMarkerText format ["Liberated %1",_townType];
_mrk setMarkerColor "ColorWEST";
_mrk setMarkerType "b_unknown";
SEN_ClearedCitys pushBack _townName;
publicVariable "SEN_ClearedCitys";

SEN_approvalCiv = SEN_approvalCiv + _approval;
publicVariable "SEN_approvalCiv";

JK_TicketSystem = JK_TicketSystem + _tickets;
publicVariable "JK_TicketSystem";
if (SEN_debug) then {(format["SEN_occupy_AO_%1",_townName]) setMarkerColor "ColorWEST"};

uiSleep 10;

for "_i" from floor(random 10) to 0 do {
    if (random 1 < 0.25) then {[_pos,SEN_enemySide,_radius+200] spawn SEN_fnc_spawnReinforcements; sleep 10;};
};

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
        sleep 0.0001;
    };
};
*/
