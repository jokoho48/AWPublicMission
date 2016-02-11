/*
 * Author: joko // Jonas
 * Generate RBU Variables Dynamicly
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
*/
jtog_rbu_enabled       = true;
jtog_rbu_markerName    = [];
jtog_rbu_blacklist     = [];
jtog_rbu_hearing       = 800;
jtog_rbu_searchRad     = 750;
jtog_rbu_numberOfAi    = 3;
jtog_rbu_aiMode        = "FULL";
jtog_rbu_walkTime      = 15;
jtog_rbu_waypoints     = 10;
jtog_rbu_ehIndex       = nil;

jtog_rbu_debug = SEN_debug;
{
    private _position = getPos _x;
    _position deleteAt 2;
    private _size = size _x;
    _size = [_size select 0 * 2, _size select 1 * 2];
    [_position, _size] call JK_fnc_addNewLocation;
} count SEN_whitelistLocation;


JK_fnc_addNewLocation = {
    params ["_position", "_size"];
    _name = format ["%1%2%3%4%5%6%7%8%9%",random 100, random 100, random 100, random 100, random 100, random 100, random 100, random 100, random 100];
    [_name, getPos _x, "Rectangle", _size, "GLOBAL", "COLOR:", "ColorYellow", "BRUSH:", "Solid"] call CBA_fnc_createMarker;
    if (!SEN_debug) then {
        _name setMarkerAlpha 0;
    };
    jtog_rbu_markerName pushBack _name;
};

JK_fnc_addBlackList = {
    params [["_var", objNull, ["", objNull, grpNull]]];
    switch (typeName _var) do {
        case ("STRING"): {
            {
                jtog_rbu_blacklist pushBack _x;
                nil
            } count allMissionObjects _var;
        };
        case ("OBJECT"): {
            jtog_rbu_blacklist pushBack _var;
        };
        case ("GROUP"): {
            {
                jtog_rbu_blacklist pushBack _x;
                nil
            } count units _var;
        };
    };
}
