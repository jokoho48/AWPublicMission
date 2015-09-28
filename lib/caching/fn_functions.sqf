JK_fnc_checkPlayerDistance = {
    private "_distanceType";
    params ["_grp", "_distance1", "_distance2"];
    _distanceType = 0;
    _leader = if (typeName _grp == "STRING") then {
        getMarkerPos _grp
    } else {
        leader _grp
    };

    {
        if ((_x distance _leader) >= _distance1) exitWith {
            if ((_x distance _leader) >= _distance2) then {
                _distanceType = 1;
            } else {
                _distanceType = 2;
            };
        };
    } count allPlayers;
    _distanceType
};

JK_fnc_cacheLeader = {
    private ["_grpVariable", "_grpOld"];
    params ["_grp"];
    _grpVariable = [];
    _grpOld = (units _grp);
    _grpOld = _grpOld deleteAt (_grpOld find (leader _grp));
    {
        private ["_allGear", "_className","_variable"];
        if (_x getVariable ["JK_noCache", false]) then {
             #ifdef JK_usedDifferentGear
                _allGear = [_x] call ace_common_fnc_getAllGear;
            #else
                _allGear = [];
            #endif
            _className = typeOf _x;
            _variable = [_className, _allGear];
            _grpVariable pushBack _variable;
            deleteVehicle _x;
        };
    } count _grpOld;
    _grp setVariable ["JK_CachedUnits", _grpVariable, false];
};

JK_fnc_uncacheLeader = {
    private "_grpVariable";
    params ["_grp"];
    _grpVariable = _grp getVariable "JK_CachedUnits";
    if (isNil "_grpVariable") exitWith {};
    _pos = (getPos (leader _grp)) findEmptyPosition [0, 10];
    {
        private "_unit";
        _x params ["_allGear", "_className"];
        _unit = createVehicle [_className, _pos];
        #ifdef JK_usedDifferentGear
            [_unit, _allGear] call ace_respawn_fnc_restoreGear;
        #endif
    } count _grpVariable;
    _grp setVariable ["JK_CachedUnits", nil, false];
};

JK_fnc_cacheAll = {
    params ["_grp", "_leader", "_var", "_mrk"];
    _grpOld = (units _grp);
    _leader = leader _grp;
    _var = format ["JK_CachedMarker_%1", JK_CachedMarker];
    _mrk = createMarkerLocal [_var, getPos _leader];
    JK_CachedMarker = JK_CachedMarker + 1;
    _grpVariable = _grp getVariable ["JK_CachedUnits", []];
     if (isNil "_grpVariable") then {
        _grpVariable = []
    };

    {
        private ["_allGear", "_className","_variable"];
        if (_x getVariable ["JK_noCache", false]) then {
             #ifdef JK_usedDifferentGear
                _allGear = [_x] call ace_common_fnc_getAllGear;
            #else
                _allGear = [];
            #endif
            _className = typeOf _x;
            _variable = [_className, _allGear];
            _grpVariable pushBack _variable;
            deleteVehicle _x;
        };
    } count (units _grp);

    missionNameSpace setVariable [_var, _grpVariable];
    JK_cachedAllArray pushBack _var;
};

JK_fnc_uncacheAll = {
    private ["_grpVariable", "_pos"];
    params ["_var"];
    _grpVariable = missionNamespace getVariable _var;
    if (isNil "_grpVariable") exitWith {};
    _pos = (getMarkerPos _var) findEmptyPosition [0, 10];
    {
        private "_unit";
        _x params ["_allGear", "_className"];
        _unit = createVehicle [_className, _pos];
        #ifdef JK_usedDifferentGear
            [_unit, _allGear] call ace_respawn_fnc_restoreGear;
        #endif
    } count _grpVariable;
    JK_cachedAllArray deleteAt (JK_cachedAllArray find _var);
    missionNamespace setVariable [_var, nil];
};
