/*
Author: SENSEI

Last modified: 8/14/2015

Description: defuse bomb before time expires
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_mrkDebug1", "_mrkDebug2", "_pos1", "_pos2", "_pos"];

SEN_defused = false;
SEN_armed = false;
SEN_codeInput = []; publicVariable "SEN_codeInput";
SEN_codeDefuse = [(round(random 9)), (round(random 9)), (round(random 9)), (round(random 9)), (round(random 9)), (round(random 9))]; publicVariable "SEN_codeDefuse";
SEN_wireDefuse = ["BLUE", "WHITE", "YELLOW", "GREEN"] select (random ((count ["BLUE", "WHITE", "YELLOW", "GREEN"]) - 1)); publicVariable "SEN_wireDefuse";
_bombTown = SEN_whitelistLocation select (random ((count SEN_whitelistLocation) - 1));
_townName = text _bombTown;
_townPos = getpos _bombTown;
_townPos set [2,0];
_townSize = size _bombTown;
_avgTownSize = (((_townSize select 0) + (_townSize select 1))/2);
_radius = (_avgTownSize*.80);
_radius2 = ((_avgTownSize*.20) max 60) min 90;
diag_log str _radius2;
//hint str _radius2;

_taskID = "defuse";
_taskText = "Defuse Explosives";
_taskDescription = format["Intel obtained from the enemy officer details several explosive devices planted througout %1 (%2). If the detonator triggers, innocent civilians will die; we cannot allow this.<br/><br/>Find the defusal code on a laptop located in the settlement and disarm the detonator.",_townName,mapGridPosition _townPos];

// A2 map compatibility
_centerCheck = isClass (configfile >> "CfgWorlds" >> worldName >> "Names" >> ("ACityC_" + _townName));
if (_centerCheck) then {_townPos = getArray (configfile >> "CfgWorlds" >> worldName >> "Names" >> ("ACityC_" + _townName) >> "position")};

[0,"Defuse Explosives: Town name: %1.",_townName] call SEN_fnc_log;

_platform1 = "Land_MetalBarrel_F" createVehicle [0,0,0];
_platform2 = "Land_MetalBarrel_F" createVehicle [0,0,0];
SEN_defuseObj = "Land_SatellitePhone_F" createVehicle [0,0,0]; publicVariable "SEN_defuseObj";
SEN_intelObj = "Land_Laptop_device_F" createVehicle [0,0,0]; publicVariable "SEN_intelObj";

if (worldName isEqualTo "Chernarus" || {worldName isEqualTo "Chernarus_Summer"}) then {
    waitUntil {
            sleep 0.1;
            _pos = [_townPos,_radius,_radius*0.4,2,false,1.5] call SEN_fnc_findPosArray;
            !(count _pos isEqualTo 0)
        };
    _pos1 = (_pos select 0);
    _pos2 = (_pos select 1);
    _platform1 setPosATL _pos1;
    _platform1 setVectorUp (surfacenormal (getPosATL _platform1));
    _platform2 setPosATL _pos2;
    _platform2 setVectorUp (surfacenormal (getPosATL _platform2));
} else {
    waitUntil {
            sleep 0.1;
            _pos = [_townPos,_radius,_radius*0.4,2,false,1.5] call SEN_fnc_findPosArray;
            !(count _pos isEqualTo 0)
        };
    _houseArray = [_townPos,_radius] call SEN_fnc_findHousePos;
    if (count (_houseArray select 1) isEqualTo 0) then {
        _pos1 = (_pos select 0);
        _platform1 setPosATL _pos1;
        _platform1 setVectorUp (surfacenormal (getPosATL _platform1));
    } else {
        _pos1 = _houseArray select 1;
        _platform1 setPosATL _pos1;
        _platform1 setVectorUp [0,0,1];
    };
    _houseArray = [_townPos,_radius] call SEN_fnc_findHousePos;
    if (count (_houseArray select 1) isEqualTo 0) then {
        _pos2 = (_pos select 1);
        _platform2 setPosATL _pos2;
        _platform2 setVectorUp (surfacenormal (getPosATL _platform2));
    } else {
        _pos2 = _houseArray select 1;
        _platform2 setPosATL _pos2;
        _platform2 setVectorUp [0,0,1];
    };
};

SEN_intelObj setposATL [((getposATL _platform1) select 0), ((getposATL _platform1) select 1), ((getposatl _platform1) select 2) + 0.825];
SEN_intelObj setVectorUp [0,0,1];
SEN_intelObj attachTo [_platform1];
SEN_defuseObj setposATL [((getposATL _platform2) select 0), ((getposATL _platform2) select 1), ((getposatl _platform2) select 2) + 0.825];
SEN_defuseObj setVectorUp [0,0,1];
SEN_defuseObj attachTo [_platform2];
_platform1 allowdamage false;
_platform2 allowdamage false;
SEN_defuseObj allowDamage false;
SEN_intelObj allowDamage false;
_grpArray = [_townPos,SEN_enemySide,8,.25] call SEN_fnc_spawnSquad;
_vehArray = _grpArray select 1;
_grp = _grpArray select 2;
[_grp] spawn SEN_fnc_setPatrolGroup;
if !(count _vehArray isEqualTo 0) then {
    [group (_vehArray select 0),_townPos,500] call BIS_fnc_taskPatrol;
};

_mrkDet = createMarker ["SEN_defuse1_mrk",([getPosATL SEN_defuseObj,0,_radius2] call SEN_fnc_findRandomPos)];
_mrkDet setMarkerColor "ColorRED";
_mrkDet setMarkerShape "ELLIPSE";
_mrkDet setMarkerAlpha 0.7;
_mrkDet setMarkerSize [_radius2,_radius2];
_mrkDefuse = createMarker ["SEN_defuse2_mrk",([getPosATL SEN_intelObj,0,_radius2] call SEN_fnc_findRandomPos)];
_mrkDefuse setMarkerColor "ColorRED";
_mrkDefuse setMarkerShape "ELLIPSE";
_mrkDefuse setMarkerAlpha 0.7;
_mrkDefuse setMarkerSize [_radius2,_radius2];
if (SEN_debug isEqualTo 1) then {
    _mrkDebug1 = createMarker ["SEN_defuse3_mrk",(getposATL SEN_defuseObj)];
    _mrkDebug1 setMarkerType "mil_dot";
    _mrkDebug1 setMarkerText "DET";
    _mrkDebug1 setMarkerColor "ColorEAST";
    _mrkDebug2 = createMarker ["SEN_defuse4_mrk",(getposATL SEN_intelObj)];
    _mrkDebug2 setMarkerType "mil_dot";
    _mrkDebug2 setMarkerText "CODE";
    _mrkDebug2 setMarkerColor "ColorEAST";
};

[WEST,[_taskID],[_taskDescription, _taskText, ""],objNull,false,2,true,"Search",false] call BIS_fnc_taskCreate;

[_townPos, 3600] spawn SEN_fnc_timerBomb;

waitUntil {sleep 5; (SEN_armed || SEN_defused || SEN_taskSuccess isEqualTo 1)};

if (SEN_taskSuccess isEqualTo 1) then {
    _nearPlayers = [getposATL SEN_intelObj,5] call SEN_fnc_getNearPlayers;
    [[[], {uiSleep 0.5; [format["<t size='0.6'>Code: %1</t>", SEN_codeDefuse]] spawn bis_fnc_dynamicText;}], "BIS_fnc_call", _nearPlayers] call BIS_fnc_MP;
    deleteVehicle SEN_intelObj;
    waitUntil {sleep 5; SEN_armed || SEN_defused};
};

if (SEN_armed) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
    SEN_whitelistLocation = SEN_whitelistLocation - [_bombTown];
    deleteVehicle SEN_intelObj;
    deleteVehicle SEN_defuseObj;
    SEN_objectCleanup append [_platform1,_platform2];
    SEN_markerCleanup append [_mrkDefuse,_mrkDet];
    if (SEN_debug isEqualTo 1) then {SEN_markerCleanup append [_mrkDebug1,_mrkDebug2]};
    [] call SEN_fnc_setTask;
};

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
deleteVehicle SEN_intelObj;
deleteVehicle SEN_defuseObj;
SEN_objectCleanup append [_platform1,_platform2];
SEN_markerCleanup append [_mrkDefuse,_mrkDet];
if (SEN_debug isEqualTo 1) then {SEN_markerCleanup append [_mrkDebug1,_mrkDebug2]};
[] call SEN_fnc_setTask;
