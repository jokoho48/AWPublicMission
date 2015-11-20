jk_fnc_cache = {
    _toCache = (units _group) - [(_leader)];
    {
        if (!(isPlayer _x) && {!("driver" in assignedVehicleRole _x)}) then {
            _x enablesimulationglobal false;
            _x hideobjectglobal true;
            _x disableAI "TARGET";
            _x disableAI "AUTOTARGET";
            _x disableAI "MOVE";
            _x disableAI "ANIM";
            _x disableAI "FSM";
        };
        nil
    } count _toCache;
};

jk_fnc_unCache = {
    _toCache = (units _group);
    {
        _x enablesimulationglobal true;
        _x hideobjectglobal false;
        _x enableAI "TARGET";
        _x enableAI "AUTOTARGET";
        _x enableAI "MOVE";
        _x enableAI "ANIM";
        _x enableAI "FSM";
        nil
    } count _toCache;
};

jk_fnc_uncacheEvent = {
    ({_x distance _leader < JK_aiUnCacheDist} count allPlayers > 0) || !isNull (_leader findNearestEnemy _leader)
};

jk_fnc_cacheEvent = {
    !(({_x distance _leader < JK_aiCacheDist} count allPlayers > 0) || !isNull (_leader findNearestEnemy _leader))
};

jk_fnc_setPosFull = {
    _toCache = (units _group) - [(_leader)];
    _near = _leader nearTargets 150;
    diag_log format ["setPos for Group %1", _group];
    {
        private ["_unit", "_testpos"];
        _unit = _x;
        _testpos = (formationPosition _x);
        if (!(isNil "_testpos") && (count _testpos > 0)) then {
            if (!(isPlayer _x) && (vehicle _x isEqualTo _x)) then {
                _testpos set [2,0];
                _x setPos _testpos;
            };
        };
        if (_near isEqualTo []) then {
            {
                _unit reveal [_x select 4, _x select 5];
                nil
            } count _near;
        };
        nil
    } count _toCache;
};
