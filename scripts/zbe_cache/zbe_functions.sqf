zbe_deleteunitsnotleaderfnc = {
    {
        deleteVehicle _x;
        nil
    } count units _this - [leader _this];
};

zbe_deleteunitsnotleader = {
    {
        _x call zbe_deleteunitsnotleaderfnc;
        nil
    } count allGroups;
};

zbe_cache = {
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

zbe_unCache = {
    {
        if (!(isPlayer _x) && {!("driver" in assignedVehicleRole _x)}) then {
            _x enablesimulationglobal true;
            _x hideobjectglobal false;
            _x enableAI "TARGET";
            _x enableAI "AUTOTARGET";
            _x enableAI "MOVE";
            _x enableAI "ANIM";
            _x enableAI "FSM";
        };
        nil
    } count _toCache;
};

zbe_closestUnit = {
    private["_dist", "_udist"];
    params ["_units", "_unit"];
    _dist = 10^5;
    {
        _udist = _x distance _unit;
        if (_udist < _dist) then {
            _dist = _udist;
        };
        nil
    } count _units;
    _dist
};

zbe_setPosLight = {
    {
        _testpos = (formationPosition _x);
        if (!(isNil "_testpos") && (count _testpos > 0)) then {
            if (!(isPlayer _x) && (vehicle _x isEqualTo _x)) then {
                _x setPos _testpos;
            };
        };
        nil
    } count _toCache;
};

zbe_setPosFull = {
    _near = (leader (_toCache select 0)) nearTargets 100;
    {
        private "_unit";
        _unit = _x;
        _testpos = (formationPosition _x);
        if (!(isNil "_testpos") && (count _testpos > 0)) then {
            if (!(isPlayer _x) && (vehicle _x isEqualTo _x)) then {
                _testpos set [2,0];
                _x setPos _testpos;
            };
        };
        {
            _unit reveal [_x select 4, _x select 5];
        } count _near;
        nil
    } count _toCache;
};

zbe_removeDead = {
    _delete = 0;
    {
        if !(alive _x) then {
            _x enablesimulation true;
            _x hideobject false;
            if (SEN_debug) then {
                [0,format ["ZBE_Cache %1 died while cached from group %2, uncaching and removing from cache loop",_x,_group]] call SEN_fnc_log;
            };
            _toCache deleteAt _forEachIndex - _delete;
            _delete = _delete + 1;
        };
    } forEach _toCache;
};

zbe_cacheEvent = {
    ({_x distance _leader < _distance} count allPlayers > 0) || !isNull (_leader findNearestEnemy _leader)
};

zbe_vehicleCache = {
    _vehicle enablesimulationglobal false;
    _vehicle hideobjectglobal true;
    _vehicle disableAI "TARGET";
    _vehicle disableAI "AUTOTARGET";
    _vehicle disableAI "MOVE";
    _vehicle disableAI "ANIM";
    _vehicle disableAI "FSM";
};

zbe_vehicleUncache = {
    _vehicle enablesimulationglobal true;
    _vehicle hideobjectglobal false;
    _vehicle enableAI "TARGET";
    _vehicle enableAI "AUTOTARGET";
    _vehicle enableAI "MOVE";
    _vehicle enableAI "ANIM";
    _vehicle enableAI "FSM";
};
