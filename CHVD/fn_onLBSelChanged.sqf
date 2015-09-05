private ["_index","_terrainGrid"];
params ["_index", "_varType", "_text"];

if (!CHVD_allowNoGrass) then {
    _index = _index + 1;
};

switch (_index) do {
    case 0: {_terrainGrid = 50};
    case 1: {_terrainGrid = 25};
    case 2: {_terrainGrid = 12.5};
    case 3: {_terrainGrid = 3.125};
};

if (!CHVD_allowNoGrass) then {
    _terrainGrid = _terrainGrid min 48.99;
};
ctrlSetText [_text, str _terrainGrid];
missionnamespace setVariable [_varType, _terrainGrid];
profileNamespace setVariable [_varType, _terrainGrid];
[] call CHVD_fnc_updateTerrain;
