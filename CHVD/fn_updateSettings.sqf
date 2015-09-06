params [["_updateType", 0, [0]], "_inUAV"];
if (isNil "_inUAV") then { _inUAV = UAVControl (getConnectedUAV player) select 1 != ""};
if (_inUAV) then {
    if (getConnectedUAV player isKindOf "LandVehicle" || getConnectedUAV player isKindOf "Ship")exitWith {
        if (_updateType in [0, 1, 3]) then {
            setViewDistance CHVD_car;
        };
        if (_updateType in [0, 2, 3]) then {
            setObjectViewDistance CHVD_carObj;
        };
    };
    if (getConnectedUAV player isKindOf "Man") exitWith {
        if (_updateType in [0, 1, 3]) then {
            setViewDistance CHVD_foot;
        };
        if (_updateType in [0, 2, 3]) then {
            setObjectViewDistance CHVD_footObj;
        };
    };
    if (_updateType in [0, 1, 3]) then {
        setViewDistance CHVD_air;
    };
    if (_updateType in [0, 2, 3]) then {
        setObjectViewDistance CHVD_airObj;
    };
} else {
    if (vehicle player isKindOf "LandVehicle" || vehicle player isKindOf "Ship") exitWith {
        if (_updateType in [0, 1, 3]) then {
            setViewDistance CHVD_car;
        };
        if (_updateType in [0, 2, 3]) then {
            setObjectViewDistance CHVD_carObj;
        };
    };
    if (vehicle player isKindOf "Air") exitWith {
        if (_updateType in [0, 1, 3]) then {
            setViewDistance CHVD_air;
        };
        if (_updateType in [0, 2, 3]) then {
            setObjectViewDistance CHVD_airObj;
        };
    };
    if (_updateType in [0, 1, 3]) then {
        setViewDistance CHVD_foot;
    };
    if (_updateType in [0, 2, 3]) then {
        setObjectViewDistance CHVD_footObj;
    };
};
if (_updateType == 0) then {
    [_inUAV] call CHVD_fnc_updateTerrain;
};
