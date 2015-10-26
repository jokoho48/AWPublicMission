/*
    File: fn_buildCfg.sqf
    Author: joko // Jonas

    Description:
    Builds our configuration arrays for vehicles to display.

    0: classname
    1: costs
    2: displayname
    3: picture
*/

if !(JK_buildNotDone) exitWith {};
if (JK_vvsArray isEqualTo []) exitWith {};
JK_allVVSVars = [];
//Setup our final arrays.
{
    private ["_tempArray"];
    _x params ["_name", "_classNames", "_cost", "_spawnType", "_varName"];
    if (_spawnType == "All" || _spawnType in JK_vvsArray) then {
        _tempArray = [];
        {
            private "_cfg";
            _cfg = [_x] call VVS_fnc_cfgInfo;
            _tempArray pushBack [_x, _cost, _cfg select 0, _cfg select 1];
            nil
        } count _classNames;
        _varName = format ["JK_VVS_%1", _varName];
        missionNameSpace setVariable [_varName, [_name ,_tempArray]];
        JK_allVVSVars pushBack _varName;
        JK_allVVSNames pushBack _name;
    };
    nil
} count JK_ListTickets;
JK_buildNotDone = false;
