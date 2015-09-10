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
    "steal"
];

SEN_taskListCiv = [
    "rescue",
    "deliver",
    "stabilize",
    "identify"
];

if (count SEN_taskList < SEN_totalTaskCount) then {SEN_totalTaskCount = count SEN_taskList};

execVM "tasks\SEN_task_officer.sqf";
sleep 15;
call SEN_fnc_setTaskCiv;
execVM "tasks\SEN_task_rebel_civ.sqf";
