/*
Author: SENSEI

Last modified: 12/29/2014

Description: spawn static emplacements

             returns group
__________________________________________________________________*/
private ["_gunnerArray", "_posArray", "_counter", "_unit", "_static1", "_static2", "_static3", "_random", "_roads", "_s", "_road", "_roadConnectedTo", "_dir", "_staticPos", "_check", "_static", "_grp", "_gunner", "_bunker", "_fort", "_fortPos", "_mrk"];
params [["_pos", [0,0,0], [[]]], ["_range", 100, [0]], ["_count", 1, [0]], ["_type", -1, [0]], ["_side", SEN_enemySide]];

_gunnerArray = [];
_posArray = [];
_counter = 50;

call {
    if (_side isEqualTo EAST) exitWith {_unit = SEN_unitPool select (random ((count SEN_unitPool) - 1)); _static1 = "O_GMG_01_high_F"; _static2 = "RHS_NSV_TriPod_MSV"; _static3 = "O_Mortar_01_F"};
    if (_side isEqualTo WEST) exitWith {_unit = SEN_unitPoolWest select (random ((count SEN_unitPoolWest) - 1)); _static1 = "B_GMG_01_high_F"; _static2 = "B_HMG_01_high_F"; _static3 = "B_Mortar_01_F"};
    if (_side isEqualTo CIVILIAN) exitWith {_unit = SEN_unitPoolCiv select (random ((count SEN_unitPoolCiv) - 1)); _static1 = "B_GMG_01_high_F"; _static2 = "B_HMG_01_high_F"; _static3 = "B_Mortar_01_F"};

    _unit = SEN_unitPool select (random ((count SEN_unitPool) - 1)); _static1 = "I_GMG_01_high_F"; _static2 = "I_HMG_01_high_F"; _static3 = "I_Mortar_01_F";
};

_random = if (_type isEqualTo -1) then {true} else {false};
_roads = _pos nearRoads _range;

for "_s" from 0 to _counter do {
    call {
        if (_random) then {_type = ceil random 3};

        if (_type isEqualTo 1) exitWith { // open static
            if (count _roads < 1) exitWith {};
            _road = _roads select (random ((count _roads) - 1));
            _roadConnectedTo = (roadsConnectedTo _road) select 0;
            if (isNil "_roadConnectedTo") exitWith {};
            _dir = [_road, _roadConnectedTo] call BIS_fnc_DirTo;
            _staticPos = [getposATL _road, getposATL _roadConnectedTo] call SEN_fnc_findThirdPos;
            _check = _staticPos isFlatEmpty [2, 0, 0.4, 2, 0, false, objNull];

            if (count _posArray > 0) then { { if (_x distance _staticPos < 20) exitWith {_check = []}} forEach _posArray};
            if (count _check isEqualTo 0 || {isOnRoad _staticPos}) exitWith {};

            _posArray pushBack _staticPos;
            _static = _static1 createVehicle [0,0,0];
            _static setPos _staticPos;
            _static setVectorUp surfaceNormal position _static;

            if (count (lineIntersectsObjs [[(getposasl _static) select 0,(getposasl _static) select 1,((getposasl _static) select 2) + 0.5], ATLToASL(_static modelToWorld [0,30,0.5])]) > 0) exitWith {deleteVehicle _static};

            _grp = createGroup _side;
            _gunner = _grp createUnit [_unit, [0,0,0], [], 0, "NONE"];
            _gunner moveInGunner _static;
            _gunner setBehaviour "COMBAT";
            _gunner setFormDir _dir + 180;
            _gunner setDir _dir + 180;
            //_gunner disableAI "MOVE";
            _gunnerArray pushBack _gunner;
        };
        if (_type isEqualTo 2) exitWith { // bunkered static
            if (count _roads < 1) exitWith {};
            _road = _roads select (random ((count _roads) - 1));
            _roadConnectedTo = (roadsConnectedTo _road) select 0;
            _dir = [_road, _roadConnectedTo] call BIS_fnc_DirTo;
            _staticPos = [getposATL _road, getposATL _roadConnectedTo] call SEN_fnc_findThirdPos;
            _check = _staticPos isFlatEmpty [2, 0, 0.4, 3, 0, false, objNull];

            if (count _posArray > 0) then { { if (_x distance _staticPos < 20) exitWith {_check = []}} forEach _posArray};
            if (count _check isEqualTo 0 || isOnRoad _staticPos) exitWith {};

            _staticPos set [2,-0.02];
            _posArray pushBack _staticPos;
            _bunker = "Land_BagBunker_Small_F" createVehicle _staticPos;
            _bunker setDir (_dir) + 180;
            _bunker setVectorUp surfaceNormal position _bunker;

            if (count (lineIntersectsObjs [[(getposasl _bunker) select 0,(getposasl _bunker) select 1,((getposasl _bunker) select 2) + 1], ATLToASL(_bunker modelToWorld [0,30,1])]) > 0) exitWith {deleteVehicle _bunker};

            _static = createVehicle [_static2,[0,0,0], [], 0, "CAN COLLIDE"];
            _static setPosATL (_bunker modelToWorld [0,0,-0.8]);

            _grp = createGroup _side;
            _gunner = _grp createUnit [_unit, [0,0,0], [], 0, "NONE"];
            _gunner moveInGunner _static;
            _gunner setBehaviour "COMBAT";
            _gunner doWatch (_bunker modelToWorld [0,-40,1]);
            //_gunner disableAI "MOVE";
            _gunnerArray pushBack _gunner;
        };
         // mortar
        _staticPos = [_pos,0,_range] call SEN_fnc_findRandomPos;
        _check = _staticPos isFlatEmpty [3, 0, 0.55, 3, 0, false, objNull];

        if (count _posArray > 0) then { { if (_x distance _staticPos < 20) exitWith {_check = []}} forEach _posArray};
        if (count _check isEqualTo 0 || isOnRoad _staticPos) exitWith {};

        _posArray pushBack _staticPos;
        _static = _static3 createVehicle _staticPos;

        _fort = "Land_BagFence_Round_F" createVehicle [0,0,0];
        _fortPos = (_static modelToWorld [0,2.3,0]);
        _fortPos set [2,0];
        _fort setPosATL _fortPos;
        _fort setDir ([_fort, _static] call BIS_fnc_DirTo);
        _fort setVectorUp surfaceNormal position _fort;
        _fort = "Land_BagFence_Round_F" createVehicle [0,0,0];
        _fortPos = (_static modelToWorld [0,-2.3,0]);
        _fortPos set [2,0];
        _fort setPosATL _fortPos;
        _fort setDir ([_fort, _static] call BIS_fnc_DirTo);
        _fort setVectorUp surfaceNormal position _fort;
        _fort = "Land_BagFence_Round_F" createVehicle [0,0,0];
        _fortPos = (_static modelToWorld [-2.3,0,0]);
        _fortPos set [2,0];
        _fort setPosATL _fortPos;
        _fort setDir ([_fort, _static] call BIS_fnc_DirTo);
        _fort setVectorUp surfaceNormal position _fort;

        _grp = createGroup _side;
        _gunner = _grp createUnit [_unit, [0,0,0], [], 0, "NONE"];
        _gunner moveInGunner _static;
        _gunner setBehaviour "COMBAT";
        //_gunner disableAI "MOVE";
        _gunnerArray pushBack _gunner;
    };

    if (count _gunnerArray isEqualTo _count) exitWith {};
};

if !(count _gunnerArray isEqualTo _count) then {[1,"fn_spawnStatic. Gunner array does not equal passed count."] call SEN_fnc_log};

if(SEN_debug && {!(count _gunnerArray isEqualTo 0)}) then {
    {
        _mrk = createMarker [format["SEN_static_%1_%2",_x,getposATL _x],getposATL _x];
        _mrk setMarkerType "mil_dot";
        _mrk setMarkerColor "ColorEAST";
        _mrk setMarkerText "STATIC";
    } forEach _gunnerArray;
};

_gunnerArray
