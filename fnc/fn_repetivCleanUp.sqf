/*
    Arma Mission Enhancement - GarbageCollect\fn_serverInit.sqf

    Author: NetFusion, Edit by joko
    Description:
    This function is the entry point for the GC module. It is called by autoloader for server only. It removes unused object from the game to clean up.
    Parameter(s):
    -
    Returns:
    -
    Example:
    -
*/
if (!isServer) exitWith {};

if (SEN_HCPresent) then {[[],"SEN_fnc_repetivCleanUp",(owner SEN_HC)] call BIS_fnc_MP}; // if headless client active run loop on HC as well
SEN_markerCleanup = [];
SEN_objectCleanup = [];
JK_objectStorage = [];
// Use an OEF EH to check for new garbage every 10 seconds. We pass an empty array as storage parameter.
[] spawn {
    while {true} do {
        // Cycle through all units to detect near shells and enqueue them for removal.
        {
            // Cycle through all near shells.
            {
                // If the shell is not queued yet push it on the storage.
                if !(_x getVariable ["SEN_noClean", false]) then {
                    if (!(_x getVariable ["JK_var_queued", false])) then {
                        _x setVariable ["JK_var_queued", true];
                        JK_objectStorage pushBack [_x, time];
                    };
                };
                nil
            } count (getPos _x nearObjects ["GrenadeHand", 100]);
            nil
        } count allUnits;

        // Remove empty groups.
        {
            if !(_x getVariable ["SEN_noClean", false]) then {
                if ((count units _x) == 0) then {
                    deleteGroup _x;
                };
            };
            nil
        } count allGroups;

        {
            if !(_x getVariable ["SEN_noClean", false]) then {
                if (!(_x getVariable ["JK_var_queued", false])) then {
                    _x setVariable ["JK_var_queued", true];
                    JK_objectStorage pushBack [_x, time];
                };
            };
            nil
        } count allMissionObjects ("WeaponHolder") + allMissionObjects ("GroundWeaponHolder") + allMissionObjects ("WeaponHolderSimulated") + allDead;

        private "_delete1";
        // Cycle through the storage and check the time. Removal is done with an animation.
        if !(JK_objectStorage isEqualTo []) then {
            {
                private ["_boundingBox", "_height"];
                _x params ["_object", "_enqueueTime"];

                // If the time has not passed exit. This assumes all following object are pushed after the current one.
                if (_enqueueTime + 360 > time) exitWith {};
                if !(_object getVariable ["SEN_noClean", false]) then {

                    // Remove the object from the storage.
                    JK_objectStorage deleteAt (JK_objectStorage find _x);
                    // Disable collision with the surface.
                    _object enableSimulationGlobal false;

                    // Calculate the height of the object to determine whether its below surface.
                    _boundingBox = boundingBox _object;
                    _height = ((_boundingBox select 1) select 2) - ((_boundingBox select 0) select 2);

                    // Use an OEF EH to move the object slowly below the surface.
                    //@todo make this optional cause it should not be visible in general.
                    [{
                        private "_position";

                        params ["_args", "_idPFH"];
                        _args params ["_object", "_height"];

                        // Get the current position and subtract some value from the z axis.
                        _position = getPos _object;
                        if (surfaceIsWater _position) then {
                            _position = getPosASL _object;
                        };
                        _position set [2,  (_position select 2) - 0.05];

                        // Apply the position change.
                        _object setPos _position;

                        // If the object is below the surface delete it and remove the OEF EH.
                        if ((_position select 2) < (0 - _height)) then {
                            deleteVehicle _object;
                        };
                        if (isNull _object) then {
                            [_idPFH] call CBA_fnc_removePerFrameHandler;
                        }
                    }, 0, [_object, _height]] call CBA_fnc_addPerframeHandler;
                };
                nil
            } count +JK_objectStorage;
        };
        // markers
        if !(SEN_markerCleanup isEqualTo []) then {
            {
                deleteMarker _x;
                uiSleep 0.05;
                if (getMarkerColor _x isEqualTo "") then {
                    SEN_markerCleanup deleteAt (SEN_markerCleanup find _x);
                };
                nil
            } count SEN_markerCleanup;
        };
        // objects
        if !(SEN_objectCleanup isEqualTo []) then {

            {
                if (isNull _x) then {
                    SEN_objectCleanup deleteAt (SEN_objectCleanup find _x);
                } else {
                    if ((([getPosATL _x,800] call SEN_fnc_getNearPlayers) isEqualTo []) && {(_x isKindOf "LandVehicle" || {_x isKindOf "Air"} || {_x isKindOf "Ship"})}) then {
                        if ((([getPosATL _x,800] call SEN_fnc_getNearPlayers) isEqualTo []) && {{isPlayer _x} count (crew _x) isEqualTo 0}) then {
                            {
                                deleteVehicle _x;
                                nil
                            } count (crew _x);
                            {
                                deleteVehicle _x;
                                nil
                            } count (_x getVariable ["ace_cargo_loaded",[]]);
                            deleteVehicle _x;
                        };
                    } else {
                        if (([getPosATL _x,800] call SEN_fnc_getNearPlayers) isEqualTo []) then {deleteVehicle _x};
                    };
                };
                nil
            } count +SEN_objectCleanup;
        };
        uiSleep 30;
    };
};
