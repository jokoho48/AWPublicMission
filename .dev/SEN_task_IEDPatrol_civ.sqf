/*
Author: joko // Jonas

Description: Disarm IEDs in Citys
__________________________________________________________________*/
if (!isServer) exitWith {};
if (!(isNil "JK_taskPatrolDone") && (JK_maxIEDCount == 0 && JK_minIEDCount == 0)) exitWith {
    [] call SEN_fnc_setTaskCiv;
};

call {
    _taskID = "IEDPatrol";
    _taskText = "IED Patrol";
    _taskDescription = "Search and Defuse IEDs in the Following Citys </br>";
    _iedTowns = [];
    _iedItems =[];
    if (JK_maxIEDCount >= 5 && JK_minIEDCount >= 2) then {
        _iedTowns append JK_iedTown;
    } else {
        _temp = +JK_iedTown;
        for "_i" from floor (random (count JK_iedTown)) to 0 do {
            private "_town";
            _town = (_temp) call BIS_fnc_selectRandom;
            _iedTowns pushBack _town;
            _temp deleteAt (_temp find _town);
        };
    };

    _iedItems append iedSecondaryItems;
    _iedItems append iedSmallItems;
    _iedItems append iedMediumItems;
    _iedItems append iedLargeItems;

    _tempRealIEDs = JK_IED - JK_fakeIED;
    _townNames = [];
    {
        _iedArray = [];
        _count = 0;
        _townSize = size _x;
        _avgTownSize = (((_townSize select 0) + (_townSize select 1))*2);
        {
            if (_x in _tempRealIEDs) then {
                _count = _count + 1;
                _iedArray pushBack _x;
                _tempRealIEDs deleteAt (_tempRealIEDs find _x);
            };
            nil
        } count nearestObjects [getPos _x, [], _avgTownSize + 100];
        _fakeCount = floor (random _count) + 1;
        _townNames pushBack [_townName, _count, _iedArray];
        _taskDescription = _taskDescription + name _x + ": " + str _fakeCount + "</br>"
        nil
    } count _iedTowns;

    if (0 == ({([getPos _x, 2000] call SEN_fnc_getNearPlayers) isEqualTo []} count _townNames)) exitWith {
        [] call SEN_fnc_setTaskCiv;
    };

    if ((random 100) > 50) then {
        private "_grpArray";
        _grpArray = [];
        for "_i" from floor(random 5) to 0 do {
            private "_grp";
            _grp = [getPos (_x select 1), 0, ((call SEN_fnc_setStrength) max 6) min 15, EAST, true] call SEN_fnc_spawnGroup;

            _grpArray pushBack _grp;
        };

        (_townNames select _forEachIndex) set [3, _grpArray];
    };

};









[WEST, [_taskID], [_taskDescription, _taskText, ""], getPos _townMarker, false, -1, true, "Search", false] call BIS_fnc_taskCreate;








JK_taskPatrolDone = true;
