/*
    Author: joko // Jonas

    Description:
    Add to Entert boxes Actions for Rearming

    Parameter(s):
    0 - N: Objects
    Returns:
    - Nothing

    Example:
    [Box1,Box2] call JK_loadOut_Gear_fnc_chooseLoadout;
*/

private ["_classes","_fnc_gear_Call","_count","_string","_endString"];

_classes = ["Command","Leader","Medic","ARMan","MG","AssMG","At","Grenadier","Rifleman","Marksman","Specialist","Pilot","Crew"];
reverse _classes;
_fnc_gear_Call = {
    {
        _string = (format ["STR_JK_GEAR_%1", toUpper _x]);
        if ( isLocalized (_string)) then { _string = localize _string; } else { _string = _x; };
        _string = (format["<t color=""#00FF00"">%1</t>",_string]);
        _isCondition = call {
            if (_x == "Command") exitWith { "player distance cursortarget <5 && str(player) in JK_var_Commander" };
            if (_x == "Pilot") exitWith { "player distance cursortarget <5 && str(player) in JK_var_pilotObjects" };
            "player distance cursortarget <5"
        };
        _this addAction [_string,
        {
            [player,_this select 3] call JK_loadOut_fnc_selectGear;
        }
        ,toLower _x,_foreachindex,false,true,"",_isCondition];
        false
    } forEach _classes;
};

{
    if !(isNull _x) then {
        _x call _fnc_gear_Call;
    };
    false
} count _this;
