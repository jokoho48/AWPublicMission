/*
Author: SENSEI

Last modified: 2/2/2015

Description: spawns animals

             returns nothing
__________________________________________________________________*/
private ["_agentArray","_type","_agent"];
params ["_pos", "_expression", "_count", "_trgVar"];
_agentArray = [];
_type = "";

missionNameSpace setvariable [_trgVar,true];

if (_expression isEqualTo "hills") then {_type = "Goat_random_F"} else {_type = "Sheep_random_F"};

for "_i" from 0 to (_count - 1) do {
    _agent = createAgent [_type, _pos, [], 150, "NONE"];
    _agentArray pushBack _agent;
};

waitUntil {uiSleep 30; !(missionNameSpace getVariable [_trgVar,false])};

SEN_objectCleanup append _agentArray;
