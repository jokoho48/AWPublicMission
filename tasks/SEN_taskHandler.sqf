/*
Author: SENSEI

Last modified: 8/14/2015

Description: starts task generation
__________________________________________________________________*/
SEN_taskSuccess = 0;
SEN_taskCounter = 0;
SEN_taskCounterCiv = 0;
SEN_taskSleepCiv = 1800; // time (sec) between civilian tasks
SEN_totalTaskCount = (paramsArray select 9);

SEN_taskList = [
    "defend",
    "repair",
    "vip",
    "defuse",
    "arty",
    "cache",
    "steal",
    "poi"
];

SEN_taskListCiv = [
    "rescue",
    "deliver",
    "stabilize",
    "identify",
    "SAR"
];

for "_s" from floor(random 10) to 0 step -1 do {
    SEN_taskList = [SEN_taskList] call CBA_fnc_shuffle;
    SEN_taskListCiv = [SEN_taskListCiv] call CBA_fnc_shuffle;
};

if (count SEN_taskList < SEN_totalTaskCount) then {SEN_totalTaskCount = count SEN_taskList};

SEN_fnc_rebelTastCiv = compile preprocessFileLineNumbers "tasks\SEN_task_rebel_civ.sqf";
JK_fnc_airAttack = compile preprocessFileLineNumbers "tasks\SEN_task_AirAttack.sqf";
JK_fnc_airAttackSingle = compile preprocessFileLineNumbers "tasks\SEN_task_AirAttackSingle.sqf";
[] spawn compile preprocessFileLineNumbers "tasks\SEN_task_officer.sqf";
call SEN_fnc_setTaskCiv;
[] spawn SEN_fnc_rebelTastCiv;
