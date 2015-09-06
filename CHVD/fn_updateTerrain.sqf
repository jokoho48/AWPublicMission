if (params ["_inUAV"]) then {_inUAV = UAVControl (getConnectedUAV player) select 1 != ""};

if (_inUAV) then {
    if (getConnectedUAV player isKindOf "LandVehicle" || getConnectedUAV player isKindOf "Ship") exitWith {
        setTerrainGrid CHVD_carTerrain;
    };
    if (getConnectedUAV player isKindOf "Man") exitWith {
        setTerrainGrid CHVD_footTerrain;
    };
    setTerrainGrid CHVD_airTerrain;
} else {
    if (vehicle player isKindOf "LandVehicle" || vehicle player isKindOf "Ship") exitWith {
        setTerrainGrid CHVD_carTerrain;
    };
    if (vehicle player isKindOf "Air") exitWith {
        setTerrainGrid CHVD_airTerrain;
    };
    setTerrainGrid CHVD_footTerrain;
};
