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
    [_this, format ["<t color='#52c652'>%1</t>", localize "STR_JK_GEAR_MC"], {JK_Gear = "USMC"},  {JK_Gear == "Main"}, nil, 98, 3] call JK_Core_fnc_addAction;
    [_this, format ["<t color='#c6c6c6'>%1</t>", localize "STR_JK_GEAR_AR"], {JK_Gear = "USARMY"},  {JK_Gear == "Main"}, nil, 98, 3] call JK_Core_fnc_addAction;
    [_this, format ["<t color='#fa6bff'>%1</t>", localize "STR_JK_GEAR_SO"], {JK_Gear = "USSOF"},  {JK_Gear == "Main"}, nil, 98, 3] call JK_Core_fnc_addAction;
    [_this, format ["<t color='#e1b10a'>%1</t>", localize "STR_JK_GEAR_SOF"], {JK_Gear = "USSOFlight"},  {JK_Gear == "Main"}, nil, 98, 3] call JK_Core_fnc_addAction;
    [_this, format ["<t color='#7f7fff'>%1</t>", localize "STR_JK_GEAR_PARA"], {JK_Gear = "Para"},  {JK_Gear == "Main"}, nil, 97, 3] call JK_Core_fnc_addAction;
    [_this, format ["<t color='#f9ea6b'>%1</t>", localize "STR_JK_GEAR_SPEC"], {JK_Gear = "Spec"}, {JK_Gear == "Main"}, nil, 96, 3] call JK_Core_fnc_addAction;
    [_this, format ["<t color='#AE2020'>%1</t>", localize "STR_JK_GEAR_Back"], {JK_Gear = "Main"}, {JK_Gear != "Main"}, nil, 95, 3] call JK_Core_fnc_addAction;
    {
        private ["_string", "_cond", "_color"];
        _color = "52c652";
        _cond = call {
            if (_x in JK_USMC) exitWith {_color = "52c652";"JK_Gear == 'USMC'"};
            if (_x in JK_USARMY) exitWith {_color = "c6c6c6";"JK_Gear == 'USARMY'"};
            if (_x in JK_USSOF) exitWith {_color = "fa6bff";"JK_Gear == 'USSOF'"};
            if (_x in JK_USSOFlight) exitWith {_color = "e1b10a";"JK_Gear == 'USSOFlight'"};
            if (_x in JK_Para) exitWith {_color = "7f7fff";"JK_Gear == 'Para'"};
            if (_x in JK_SpecialClasses) exitWith {_color = "f9ea6b";"JK_Gear == 'Spec'"};
            "true"
        };

        _string = (format ["STR_JK_GEAR_%1", toUpper _x]);
        if ( isLocalized (_string)) then { _string = localize _string; } else { _string = _x; };
        _string = (format["<t color='#%2'>%1</t>",_string, _color]);
        [_this, _string, {
            ["Loadouts:" + (_this select 3), player, "JK_loadOut_fnc_selectGear", true, 1] remoteExec ["db_fnc_codeload", 2, false];
            JK_Gear = "Main";
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
