_pos = [_townPos,(SEN_range*0.07 max 1000),_radius] call SEN_fnc_findRandomPos;
if (_pos distance SEN_centerPos <= SEN_range && {!(surfaceIsWater _pos)} && {!([_pos, "SEN_safezone_mrk"] call SEN_fnc_checkInMarker)}) then {
    if (random 1 > ((paramsArray select 6)*.01)) then {
        _grp = [_pos,0,(4 + round(random 4))] call SEN_fnc_spawnGroup; // infantry
        [_grp,_pos,(SEN_range*0.08 max 1000), floor (random 8) max 3,"MOVE", "SAFE", "RED", "LIMITED", (selectRandom ["COLUMN", "STAG COLUMN"]), "", [2,6,12]] call CBA_fnc_taskPatrol;
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
};
if !(_check isEqualTo _count) then {
    call JK_fnc_createPatrolUnit;
};
