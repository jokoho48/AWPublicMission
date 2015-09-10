/*
@filename: initPlayerLocal.sqf
Author:

    Quiksilver

Last modified:

    29/10/2014 ArmA 1.32 by Quiksilver

Description:

    Client scripts and event handlers.
______________________________________________________*/

enableSentences false;
enableSaving [false,false];
player enableFatigue true;

[Quartiermeister] call JK_loadOut_fnc_chooseLoadout;
[player] call JK_loadOut_fnc_loadoutsInit;

//------------------------------------------------ Handle parameters

for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
    call compile format
    [
        "PARAMS_%1 = %2",
        (configName ((missionConfigFile >> "Params") select _i)),
        (paramsArray select _i)
    ];
};

//------------------- client executions

_null = [] execVM "scripts\restrictions.sqf";                                     // gear restrictions and safezone
_null = [] execVM "scripts\pilotCheck.sqf";                                     // pilots only
_null = [] execVM "scripts\misc\diary.sqf";                                        // diary tabs
_null = [] execVM "scripts\icons.sqf";                                            // blufor map tracker Quicksilver
//_null = [] execVM "scripts\VAclient.sqf";                                        // Virtual Arsenal
_null = [] execVM "scripts\misc\Intro.sqf";                                        // AW intro screen
if (PARAMS_HeliRope != 0) then {call compile preprocessFileLineNumbers "scripts\vehicle\fastrope\zlt_fastrope.sqf";};
if (PARAMS_HeliSling != 0) then {call compile preprocessFileLineNumbers "scripts\vehicle\sling\sling_config.sqf";};                // Heli Sling.

[] call QS_fnc_respawnPilot;


//-------------------- PVEHs

"showNotification" addPublicVariableEventHandler
{
    (_this select 1) params ["_type", ["_message", ""]];
    [_type, [_message]] call BIS_fnc_showNotification;
};

"GlobalHint" addPublicVariableEventHandler
{
    params ["_GHint"];
    hint parseText format["%1", _GHint];
};

"hqSideChat" addPublicVariableEventHandler
{
    params ["_message"];
    [WEST,"HQ"] sideChat _message;
};

"addToScore" addPublicVariableEventHandler
{
    ((_this select 1) select 0) addScore ((_this select 1) select 1);
};

"radioTower" addPublicVariableEventHandler
{
    "radioMarker" setMarkerPosLocal (markerPos "radioMarker");
    "radioMarker" setMarkerTextLocal (markerText "radioMarker");
    "radioCircle" setMarkerPosLocal (markerPos "radioCircle");
};

"sideMarker" addPublicVariableEventHandler
{
    "sideMarker" setMarkerPosLocal (markerPos "sideMarker");
    "sideCircle" setMarkerPosLocal (markerPos "sideCircle");
    "sideMarker" setMarkerTextLocal format["Side Mission: %1",sideMarkerText];
};

"priorityMarker" addPublicVariableEventHandler
{
    "priorityMarker" setMarkerPosLocal (markerPos "priorityMarker");
    "priorityCircle" setMarkerPosLocal (markerPos "priorityCircle");
    "priorityMarker" setMarkerTextLocal format["Priority Target: %1",priorityTargetText];
};

enableEngineArtillery false;
if (player isKindOf "B_support_Mort_f") then {
    enableEngineArtillery true;
};
