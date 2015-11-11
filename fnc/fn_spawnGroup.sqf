/*
Author: SENSEI

Last modified: 8/12/2015

Description: spawns group

        returns group or array
__________________________________________________________________*/
private ["_grp","_driverArray","_unitPool","_vehPool","_airPool","_veh","_unit"];

params [["_pos",[0,0,0],[[]]], ["_type",0,[0]], ["_count",1,[0]], ["_side",SEN_enemySide], ["_uncache",false]];



call {
    if (_side isEqualTo WEST) exitWith {_unitPool = SEN_unitPoolWest; _vehPool = SEN_vehPoolWest; _airPool = SEN_airPoolWest;};
    if (_side isEqualTo CIVILIAN) exitWith {_unitPool = SEN_unitPoolCiv; _vehPool = SEN_vehPoolCiv; _airPool = SEN_airPoolCiv};
    if (_side isEqualTo RESISTANCE) exitWith {_unitPool = SEN_unitPoolRebel; _vehPool = SEN_vehPoolRebel; _airPool = SEN_airPoolRebel; _side = CIVILIAN;};
    _unitPool = SEN_unitPool; _vehPool = SEN_vehPool; _airPool = SEN_airPool;
};

_grp = createGroup _side;
_grp allowfleeing 0;
_driverArray = [];

for "_j" from 0 to (_count - 1) do {
    call {
        if (_type isEqualTo 0) exitWith {
            (_unitPool call BIS_fnc_selectRandom) createUnit [_pos, _grp];
        };

        if (_type isEqualTo 2) then {
            _veh = createVehicle [(_airPoolcall BIS_fnc_selectRandom),_pos,[],0,"FLY"];
        } else {
            _veh = (_vehPool call BIS_fnc_selectRandom) createVehicle _pos;
        };

        _unit = _grp createUnit [(_unitPool call BIS_fnc_selectRandom),_pos, [], 0, "NONE"];
        _unit moveInDriver _veh;
        _driverArray pushBack _unit;

        if !((_veh emptyPositions "gunner") isEqualTo 0) then {
            _unit = _grp createUnit [(_unitPool call BIS_fnc_selectRandom),_pos, [], 0, "NONE"];
            _unit moveInGunner _veh;
        };
    };
};

if (_uncache) then {_grp setVariable ["JK_noCache", true, true]};
if (_type isEqualTo 0) exitWith {_grp};

_driverArray
