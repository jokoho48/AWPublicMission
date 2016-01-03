    /*
Author: SENSEI

Last modified: 9/11/2014

Description: sets civilians task

        returns nothing
__________________________________________________________________*/
if (!isServer) exitWith {};
[{
    private "_task";
    params [["_override","",[""]]];

    SEN_intelObjCiv = objNull;
    publicVariable "SEN_intelObjCiv";
    SEN_taskSuccess = 0;
    SEN_taskCounterCiv = SEN_taskCounterCiv + 1;
    if !(_override isEqualTo "") exitWith { [] spawn compile preprocessFileLineNumbers format ["tasks\SEN_task_%1_civ.sqf", _override]; };
    _task = SEN_taskListCiv call BIS_fnc_selectRandom;
    [] spawn compile preprocessFileLineNumbers format ["tasks\SEN_task_%1_civ.sqf", _task];
}, 15, _this] call ace_common_fnc_waitAndExecute;
