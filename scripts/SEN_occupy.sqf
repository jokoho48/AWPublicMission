/*
Author: SENSEI

Last modified: 8/8/2015

Description: occupied location and surrounding patrol setup
__________________________________________________________________*/

JK_fnc_occupyTrgAct = compile preprocessFileLineNumbers "scripts\SEN_occupyTrgAct.sqf";
_exit = "";

if (SEN_HCPresent) then {
    _exit = (isServer);
    [0,"Spawning occupied location units and patrols on headless client."] call SEN_fnc_log;
} else {
    _exit = (!isServer);
    [0,"Spawning occupied location units and patrols on server."] call SEN_fnc_log;
};

if (_exit) exitWith {[0,"Exiting SEN_occupy.sqf."] call SEN_fnc_log};

[0,"Starting SEN_occupy.sqf."] call SEN_fnc_log;

_strength = (paramsArray select 8);
_grpsize = (paramsArray select 13);
_count = if ((paramsArray select 5) isEqualTo 1) then {((ceil (SEN_range/512)) max 9) min 15} else {0}; // number of patrols per location

{
    // town vars
    _townPos = getpos _x;
    _townPos set [2,0];
    _townName = text _x;
    _townType = type _x;
    _townSize = size _x;
    _avgTownSize = (((_townSize select 0) + (_townSize select 1))/2);
    _check = 0;
    _radius = (SEN_range*0.2 max 2500);
    _grp = grpNull;

    // town type specifics
    call {
        if (_townType isEqualTo "NameCityCapital") exitWith {
            [_townPos,ceil random 4,_avgTownSize*1.5,_avgTownSize*8] call SEN_fnc_spawnSniper;
            [_townPos,_avgTownSize,2] call SEN_fnc_spawnTower;
            [_townPos, _avgTownSize*0.6, 2] call SEN_fnc_spawnStatic;
            for "_i" from 0 to _strength step _grpsize do {
                _grp = [_townPos,0,_grpsize,SEN_enemySide] call SEN_fnc_spawnGroup;
                [_grp,_avgTownSize*0.75] call SEN_fnc_setPatrolGroup;
            };
            _vehArray = [([_townPos, 50, 150, 2, 0, 1, 0] call BIS_fnc_findSafePos),1,1,SEN_enemySide] call SEN_fnc_spawnGroup;
            [(_vehArray select 0),_avgTownSize*2,false] call SEN_fnc_setPatrolVeh;
            if (random 1 < 0.5) then {
                _airArray = [_townPos,2,1] call SEN_fnc_spawnGroup;
                [(_airArray select 0),2000,true] call SEN_fnc_setPatrolVeh;
            };
        };
        if (_townType isEqualTo "NameCity") exitWith {
            [_townPos,ceil random 3,_avgTownSize*1.5,_avgTownSize*6] call SEN_fnc_spawnSniper;
            [_townPos,_avgTownSize,2] call SEN_fnc_spawnTower;
            [_townPos, _avgTownSize*0.45, 2] call SEN_fnc_spawnStatic;
            for "_i" from 0 to _strength step _grpsize do {
                _grp = [_townPos,0,_grpsize*.75,SEN_enemySide] call SEN_fnc_spawnGroup;
                [_grp,_avgTownSize*0.75] call SEN_fnc_setPatrolGroup;
            };
            if (random 1 < 0.7) then {
                _vehArray = [([_townPos, 50, 150, 2, 0, 1, 0] call BIS_fnc_findSafePos),1,1,SEN_enemySide] call SEN_fnc_spawnGroup;
                [(_vehArray select 0),_avgTownSize*2,false] call SEN_fnc_setPatrolVeh;
            };
        };
        // NameVillage
        [_townPos,ceil random 2,_avgTownSize*1.5,_avgTownSize*4] call SEN_fnc_spawnSniper;
        [_townPos,_avgTownSize,1] call SEN_fnc_spawnTower;
        [_townPos, _avgTownSize*0.45, 1] call SEN_fnc_spawnStatic;
        for "_i" from 0 to _strength step _grpsize do {
            _grp = [_townPos,0,_grpsize*.50,SEN_enemySide] call SEN_fnc_spawnGroup;
            [_grp,_avgTownSize*0.75] call SEN_fnc_setPatrolGroup;
        };
        if (random 1 < 0.3) then {
            _vehArray = [([_townPos, 50, 150, 2, 0, 1, 0] call BIS_fnc_findSafePos),1,1,SEN_enemySide] call SEN_fnc_spawnGroup;
            [(_vehArray select 0),_avgTownSize*2,false] call SEN_fnc_setPatrolVeh;
        };
    };

    if !(_count isEqualTo 0) then {
        waitUntil {
            _pos = [_townPos,(SEN_range*0.07 max 1000),_radius] call SEN_fnc_findRandomPos;
            if (_pos distance SEN_centerPos <= SEN_range && {!(surfaceIsWater _pos)} && {!([_pos, "SEN_safezone_mrk"] call SEN_fnc_checkInMarker)}) then {
                if (random 1 > ((paramsArray select 6)*.01)) then {
                    _grp = [_pos,0,(4 + round(random 4))] call SEN_fnc_spawnGroup; // infantry
                    [_grp,_pos,(SEN_range*0.08 max 1000), floor (random 8) max 3,"MOVE", "SAFE", "YELLOW", "NORMAL", (["COLUMN", "STAG COLUMN"] call BIS_fnc_selectRandom), "", [2,6,12]] call CBA_fnc_taskPatrol;
                } else {
                    _grp = [_pos,1,1] call SEN_fnc_spawnGroup; // technical
                    _driver = (_grp select 0);
                    _grp = (group _driver);
                    [_driver,(SEN_range*0.20 max 2000),false] call SEN_fnc_setPatrolVeh;
                };
                if (SEN_debug) then {
                    _mrkPatrol = createMarker [format["SEN_patrol_%1",_grp],_pos];
                    _mrkPatrol setMarkerType "o_unknown";
                    _mrkPatrol setMarkerColor "ColorEAST";
                    [_grp] spawn {
                        while {alive leader (_this select 0)} do {
                            _mrk = createMarker [format["SEN_patrol_tracking_%1",getposATL leader (_this select 0)],getposATL leader (_this select 0)];
                            _mrk setMarkerType "mil_dot";
                            _mrk setMarkerColor "ColorEAST";
                            uiSleep 30;
                        };
                    };
                };
                _check = _check + 1;
                _check isEqualTo _count
            };
        };
    };

    call {
        if (_townType isEqualTo "NameCityCapital") exitWith {
            _mrkOccupy = createMarker [format["SEN_occupy_mrk_%1", _townName], [((_townPos) select 0), ((_townPos) select 1) - 70]];
            _mrkOccupy setMarkerType "o_unknown";
            _mrkOccupy setMarkerText "Occupied Capital";
            _mrkOccupy setMarkerColor "ColorEAST";

            _trgOccupy = createTrigger ["EmptyDetector", _townPos];
            _trgOccupy setTriggerArea [((_townSize select 0) + 100),((_townSize select 1) + 100), 0, false];
            _trgOccupy setTriggerActivation ["WEST", "PRESENT", false];
            _var = format ["SEN_occupiedLocation select %1",_forEachIndex];
            _trgAct = format ["[%1,%2] spawn JK_fnc_occupyTrgAct",str _var,str _mrkOccupy];
            _trgOccupy setTriggerStatements ["this", _trgAct, ""];

        };
        if (_townType isEqualTo "NameCity") exitWith {
            _mrkOccupy = createMarker [format["SEN_occupy_mrk_%1", _townName], [((_townPos) select 0), ((_townPos) select 1) - 70]];
            _mrkOccupy setMarkerType "o_unknown";
            _mrkOccupy setMarkerText "Occupied City";
            _mrkOccupy setMarkerColor "ColorEAST";

            _trgOccupy = createTrigger ["EmptyDetector", _townPos];
            _trgOccupy setTriggerArea [((_townSize select 0) + 100),((_townSize select 1) + 100), 0, false];
            _trgOccupy setTriggerActivation ["WEST", "PRESENT", false];
            _var = format ["SEN_occupiedLocation select %1",_forEachIndex];
            _trgAct = format ["[%1,%2] spawn JK_fnc_occupyTrgAct",str _var,str _mrkOccupy];
            _trgOccupy setTriggerStatements ["this", _trgAct, ""];
        };

        _mrkOccupy = createMarker [format["SEN_occupy_mrk_%1", _townName], [((_townPos) select 0), ((_townPos) select 1) - 70]];
        _mrkOccupy setMarkerType "o_unknown";
        _mrkOccupy setMarkerText "Occupied Town";
        _mrkOccupy setMarkerColor "ColorEAST";

        _trgOccupy = createTrigger ["EmptyDetector", _townPos];
        _trgOccupy setTriggerArea [((_townSize select 0) + 100),((_townSize select 1) + 100), 0, false];
        _trgOccupy setTriggerActivation ["WEST", "PRESENT", false];
        _var = format ["SEN_occupiedLocation select %1",_forEachIndex];
        _trgAct = format ["[%1,%2] spawn JK_fnc_occupyTrgAct",str _var,str _mrkOccupy];
        _trgOccupy setTriggerStatements ["this", _trgAct, ""];
    };

    if (SEN_debug) then {
        _radius = (((_townSize select 0) + (_townSize select 1))/2) + 100;
        _mrk = createMarker [format["SEN_occupy_AO_%1",_townName],_townPos];
        _mrk setMarkerShape "ELLIPSE";
        _mrk setMarkerSize [_radius,_radius];
        _mrk setMarkerColor "ColorEAST";
    };
} forEach SEN_occupiedLocation;

[] call compile preprocessFileLineNumbers "tasks\SEN_taskHandler.sqf";

if (SEN_HCPresent) then {publicVariableServer "SEN_complete"};
[0,"SEN_occupy.sqf complete."] call SEN_fnc_log;
