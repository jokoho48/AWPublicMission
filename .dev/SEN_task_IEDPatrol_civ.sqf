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

        _countText = call {
            if (_count >= 5) exitWith { _max = 4; "Large" };
            if (_count >= 3) exitWith { _max = 2; "Medium" };
            _max = 1;
            "Small"

        };
        _fakeCount = floor (random _count) max _max;
        _townNames pushBack [_townName, _count, _iedArray, _fakeCount];
        _taskDescription = _taskDescription + "in " name _x + "is Reported a " + str _countText + " amount of IED's (Open)</br>";
        nil
    } count _iedTowns;

    if (0 == ({([getPos _x, 2000] call SEN_fnc_getNearPlayers) isEqualTo []} count _townNames)) exitWith {
        [] call SEN_fnc_setTaskCiv;
    };


    {
        private "_grpArray";
        _grpArray = [];
        if ((random 100) > 50) then {
            for "_i" from floor (random _townNames select 1) to 0 do {
                private "_grp";
                _grp = [getPos (_x select 1), 0, ((call SEN_fnc_setStrength) max 6) min 15, EAST, true] call SEN_fnc_spawnGroup;
                _grpArray pushBack _grp;
            };
        };
        _pos = getPos (_x select 0);
        _mrk = createMarker [_taskID + _forEachIndex, _pos];
        (_townNames select _forEachIndex) pushBack _grpArray;
        (_townNames select _forEachIndex) pushBack _mrk;
    } forEach _townNames;
};

[WEST, [_taskID], [_taskDescription, _taskText, ""], getPos ((_townNames select 0) select 0), false, -1, true, "Search", false] call BIS_fnc_taskCreate;

// _townNames == [[_townName, _count, _iedArray, _grpArray, _marker]];

waitUntil {
    sleep 20;
    _done = false;
    {
        _x params ["", "", "_iedArray", "_fakeCount", "", "_mrk"];
        if ({!(isNull _x)} count _iedArray <= _fakeCount - 2) then {
            _done = true;
            _mrk setMarkerColor "ColorCivilian";
            _taskDescription = "Search and Defuse IEDs in the Following Citys </br>";
            _taskDescription = _taskDescription + "in " name _x + "is Reported a " + str _countText + " amount of IED's (Open)</br>";
            [_taskID, [_taskDescription, _taskText, ""]] call BIS_fnc_taskSetDescription;
            _townNames set [_forEachIndex, objNull];
        } else {
            _done = false;
        };

        {
            private "_iedObj";
            _iedObj = _x;
            if (_iedObj getVariable ["JK_grpIsAssigned", false]) then {
                _assign = false;
                {
                    if ((random 100) > 50) then {

                    };
                } forEach ([getPos _x, 2000] call SEN_fnc_getNearPlayers);
            };
        } forEach _iedArray;
    } forEach _townNames;
    _townNames = _townNames - [objNull];

    _done
};

JK_taskPatrolDone = true;
