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
JK_Gear = "Main";
_fnc_gear_Call = {
    {
        private ["_string", "_cond", "_color"];
        _color = "52c652";
        _cond = "true";
        _string = (format ["STR_JK_GEAR_%1", toUpper _x]);
        if ( isLocalized (_string)) then { _string = localize _string; } else { _string = _x; };
        _string = (format["<t color='#%2'>%1</t>",_string, _color]);
        [_this, _string, {
            ["Loadouts:" + (_this select 3), player, "JK_loadOut_fnc_selectGear", true, 1] remoteExec ["db_fnc_codeload", 2, false];
        }, _cond, _x, _foreachindex + 99, 3] call JK_Core_fnc_addAction;
    } forEach JK_classes;
};

{
    if !(isNull _x) then {
        _x call _fnc_gear_Call;
    };
    clearWeaponCargoGlobal _x;
    clearMagazineCargoGlobal _x;
    clearItemCargoGlobal _x;
    clearBackpackCargoGlobal _x;

    false
} count _this;
