/*
Author: SENSEI

Last modified: 10/20/2014

Description: handles player transport request
__________________________________________________________________*/
if (isDedicated) exitWith {};

missionNamespace setVariable ["SEN_transportRequest",[player,(_this select 0)]]; publicVariableServer "SEN_transportRequest";