/*
Author: SENSEI

Last modified: 7/18/2015

Description: postInit settings

        returns nothing
__________________________________________________________________*/
if !(isServer) exitWith {};
"SEN_safezone_mrk" setMarkerAlpha 0;
[] spawn {
waitUntil {!isNil "JK_DBSetup"};
[0,"Starting fn_settingsPost."] call SEN_fnc_log;
SEN_range = worldSize/2;
publicVariable "SEN_range";
SEN_centerPos = [SEN_range,SEN_range,0];
SEN_occupiedLocation = [];
SEN_whitelistLocation = [];

waitUntil {!isNil "SEN_blacklistLocation"};

_SEN_blacklistLocationReal = []; // location names in array will be removed from DCG. You can add to this array, however I suggest you don't remove the current locations from the list
_SEN_blacklistLocation = SEN_blacklistLocation + _SEN_blacklistLocationReal;
_SEN_safeZoneSize = ((getMarkerSize "SEN_safezone_mrk") select 0);
_SEN_safeZoneX = [((getMarkerPos "SEN_safezone_mrk") select 0) - _SEN_safeZoneSize, ((getMarkerPos "SEN_safezone_mrk") select 1) + _SEN_safeZoneSize, 0];
_SEN_safeZoneY = [((getMarkerPos "SEN_safezone_mrk") select 0) + _SEN_safeZoneSize, ((getMarkerPos "SEN_safezone_mrk") select 1) - _SEN_safeZoneSize, 0];

{ // if location is in _SEN_blacklistLocation, does not have a name or is near the MOB safezone, it is not added to DCG
    _locName = text _x;
    _locPos = getpos _x;
    _locPos set [2,0];
    if (_locPos distance (getmarkerpos "sen_safezone_mrk") > _SEN_safeZoneSize + 900) then {
        if (!(_locName in _SEN_blacklistLocation) && {!(_locName isEqualTo "")}) then {SEN_whitelistLocation pushBack _x};
    };
} forEach (nearestLocations [SEN_centerPos, ["NameCityCapital","NameCity","NameVillage"], SEN_range]);

[0,"SEN_range: %1, SEN_centerPos: %2, SEN_whitelistLocation count: %3",SEN_range, SEN_centerPos, (count SEN_whitelistLocation)] call SEN_fnc_log;

// headless client setup
if !(isNil "SEN_HC") then {
    SEN_HCPresent = true; publicVariable "SEN_HCPresent";
    [0,"Headless client: TRUE."] call SEN_fnc_log;
} else {
    SEN_HC = objNull; publicVariable "SEN_HC";
    [0,"Headless client: FALSE."] call SEN_fnc_log;
};

// safezone setup
_trgSafeZone = createTrigger ["EmptyDetector", getMarkerPos "SEN_safezone_mrk"];
_trgSafeZone setTriggerArea [_SEN_safeZoneSize, _SEN_safeZoneSize, 0, false];
_trgSafeZone setTriggerStatements ["this","{if (!(_x isKindOf 'logic')) then { {deleteVehicle _x} forEach crew _x; deleteVehicle _x; }; } forEach thisList;", ""];
if (SEN_enemySide isEqualTo EAST) then {_trgSafeZone setTriggerActivation ["EAST", "PRESENT", true]} else {_trgSafeZone setTriggerActivation ["GUER", "PRESENT", true]};

// transport setup
"SEN_transportRequest" addPublicVariableEventHandler {[_this select 1] spawn SEN_fnc_transportHandler};

// FOB request setup
"SEN_fobRequest" addPublicVariableEventHandler {[_this select 1] spawn SEN_fnc_fobRequestHandler};

// debug setup
if (SEN_debug) then {
    [] spawn {
        while {true} do {
            _allEnemy = {alive _x && {side _x isEqualTo SEN_enemySide}} count allUnits;
            _allCiv = {alive _x && {side _x isEqualTo CIVILIAN}} count allUnits;
            _allGrp = str (count allGroups);
            [0,"ENEMY COUNT: %1, CIVILIAN COUNT: %2, GROUP COUNT: %3, SERVER FPS: %4",_allEnemy,_allCiv,_allGrp,diag_fps] call SEN_fnc_log;
            uiSleep 60;
        };
    };
};

// occupied location setu
for "_s" from 1 to (paramsArray select 7) do {
    _targetTown = SEN_whitelistLocation select (random ((count SEN_whitelistLocation) - 1));
    SEN_occupiedLocation pushBack _targetTown;
    SEN_whitelistLocation = SEN_whitelistLocation - [_targetTown];
    [0,"Occupied location: Name: %1, Position: %2, Type: %3",text _targetTown,getpos _targetTown,type _targetTown] call SEN_fnc_log;

    if ((paramsArray select 10) isEqualTo 1) then {
        call {
            private ["_townPos","_townSize","_avgTownSize","_buildings","_destroyed","_wreckArray","_roads","_veh","_vehPos","_vehType","_road","_roadConnectedTo","_fx","_smokingPos","_destroyedPos"];

            [0,"Creating ruins at %1.",text _targetTown] call SEN_fnc_log;
            _townPos = getpos _targetTown;
            _townPos set [2,0];
            _townSize = size _targetTown;
            _avgTownSize = (((_townSize select 0) + (_townSize select 1))/2);
            _destroyedPos = [];
            // destroy buildings
            _buildings = _townPos nearObjects ["House",_avgTownSize];
            if (count _buildings > 0) then {
                for "_i" from 1 to ceil(((count _buildings)*0.25) min 15) do {
                    _destroyed = _buildings select (random ((count _buildings) - 1));
                    _destroyedPos pushBack (getposatl _destroyed);
                    _destroyed setDamage 1;
                    _buildings = _buildings - [_destroyed];
                };
            };

            // spawn wrecked cars
            _wreckArray = ["Land_Wreck_Truck_dropside_F","Land_Wreck_Truck_F","Land_Wreck_UAZ_F","Land_Wreck_Ural_F","Land_Wreck_Van_F","Land_Wreck_Skodovka_F","Land_Wreck_CarDismantled_F","Land_Wreck_Car3_F","Land_Wreck_Car_F"];
            _roads = _townPos nearRoads _avgTownSize;
            if (count _roads > 0) then {
                private ["_veh","_vehPos"];

                for "_i" from 0 to (ceil random 6) do {
                    _vehType = _wreckArray select (random ((count _wreckArray) - 1));
                    _road = _roads select (random ((count _roads) - 1));
                    _roadConnectedTo = (roadsConnectedTo _road);
                    if (count _roadConnectedTo > 0) then {
                        _vehPos = [getposATL _road, getposATL (_roadConnectedTo select 0)] call SEN_fnc_findThirdPos;
                        _check = _vehPos isFlatEmpty [2, 0, 1, 3, 0, false, objNull];
                        if (!isOnRoad _vehPos && {count _check > 0}) then {
                            _vehPos set [2,0];
                            _veh = _vehType createVehicle [0,0,0];
                            _veh setPosATL _vehPos;
                            _veh setDir random 360;
                            _veh setVectorUp surfaceNormal position _veh;
                            if (random 1 < 0.5) then {
                                _fx = "test_EmptyObjectForFireBig" createVehicle getposATL _veh;
                                _fx attachTo [_veh,[0,0,0]];
                            };
                        };
                    };
                };
            };

            // add smoke
            if (count _destroyedPos > 0) then {
                for "_i" from 1 to ceil(((count _destroyedPos)*0.35) min 7) do {
                    _smokingPos = _destroyedPos select (random ((count _destroyedPos) - 1));
                    _fx = "test_EmptyObjectForSmoke" createVehicle _smokingPos;
                };
            };
        };
    };
};

call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";

SEN_complete = 1;
if (SEN_HCPresent) then {
    (owner SEN_HC) publicVariableClient "SEN_centerPos";
    (owner SEN_HC) publicVariableClient "SEN_occupiedLocation";
    (owner SEN_HC) publicVariableClient "SEN_whitelistLocation";
    (owner SEN_HC) publicVariableClient "SEN_unitPoolWest";
    (owner SEN_HC) publicVariableClient "SEN_vehPoolWest";
    //(owner SEN_HC) publicVariableClient "SEN_airPoolWest";
    (owner SEN_HC) publicVariableClient "SEN_sniperPoolWest";
    (owner SEN_HC) publicVariableClient "SEN_unitPoolCiv";
    (owner SEN_HC) publicVariableClient "SEN_vehPoolCiv";
    (owner SEN_HC) publicVariableClient "SEN_airPoolCiv";
    (owner SEN_HC) publicVariableClient "SEN_unitPool";
    (owner SEN_HC) publicVariableClient "SEN_vehPool";
    (owner SEN_HC) publicVariableClient "SEN_airPool";
    (owner SEN_HC) publicVariableClient "SEN_sniperPool";
    (owner SEN_HC) publicVariableClient "SEN_officerPool";
    (owner SEN_HC) publicVariableClient "SEN_complete";
};
[0,"fn_settingsPost complete."] call SEN_fnc_log;
};
