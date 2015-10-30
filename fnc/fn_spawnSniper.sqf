/*
Author: SENSEI

Last modified: 12/23/2014

Description: spawn sniper

        returns array of groups
__________________________________________________________________*/
private ["_return","_sniper","_spotter","_overwatch","_ref1","_ref2","_overwatchHeight","_overwatchASL","_grp","_unit","_mrk"];
params [["_pos", [0, 0, 0], [[]]], ["_count", 1, [0]], ["_min", 100, [0]],["_max", 1100, [0]], ["_side", SEN_enemySide], ["_uncache", false]];
_return = [];

call {
    if (_side isEqualTo EAST) exitWith {_sniper = (SEN_sniperPool select (random ((count SEN_sniperPool) - 1)));/* _spotter = "O_spotter_F";*/};
    if (_side isEqualTo WEST) exitWith {_sniper = (SEN_sniperPoolWest select (random ((count SEN_sniperPoolWest) - 1)));;/* _spotter = "B_spotter_F";*/};

    _sniper = (SEN_sniperPool select (random ((count SEN_sniperPool) - 1))); /*_spotter = "I_spotter_F";*/
};

for "_i" from 1 to _count do {
    _overwatch = [_pos,_max,_min,-1000] call bis_fnc_findoverwatch;
    _ref1 = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];
    _ref2 = createVehicle ["Land_HelipadEmpty_F", _overwatch, [], 0, "CAN_COLLIDE"];
    _overwatchHeight = (_ref1 worldtomodel _overwatch) select 2;
    _overwatchASL = (getposASL _ref2) select 2;

    if (_overwatch isEqualTo [0,0,0] || {_overwatch isEqualTo []} || {_overwatch distance _pos > _max} || {(_overwatchHeight - ((getposASL _ref1) select 2)) < 40} || {_overwatchASL < 80}) then {
        [1,"fn_spawnSniper cannot find suitable overwatch position."] call SEN_fnc_log;
    } else {
        _grp = createGroup _side;
        _unit = _grp createUnit [_sniper, _overwatch, [], 0, "NONE"];
        _unit setUnitPos "DOWN";
        /*_unit = _grp createUnit [_spotter, _overwatch, [], 0, "NONE"];
        _unit setUnitPos "DOWN";*/
        _unit setskill ["spotDistance",0.97];
        units _grp doWatch _pos;
        _return pushBack _grp;
        _grp setBehaviour "COMBAT";

        if (_uncache) then {_grp setVariable ["JK_noCache", true, true]};

        if(SEN_debug) then {
            _mrk = createMarker [format["SEN_sniper_%1_%2",_grp,_i],getposATL leader _grp];
            _mrk setMarkerType "mil_dot";
            _mrk setMarkerColor "ColorEAST";
            _mrk setMarkerText "SNIPER";
        };
    };
    deleteVehicle _ref1;
    deleteVehicle _ref2;
};

_return
