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
JK_USMC = ["Command", "radioOp", "Leader", "FTL", "Medic", "ARMan", "MG", "AssMG", "At", "ATmk153", "AtAss", "ATAssmk153", "Grenadier", "Rifleman", "stormtrooper", "Marksman", "Specialist"];
JK_Para = ["paratrooper", "paraARman", "paraDropMedic", "paraExExpert", "paraGrenadier", "paraLeader", "paraMarksman", "paraStormtrooper", "paraAssAR"];
JK_SpeczialClasses = ["Pilot", "Crew", "jetPilot", "pjMedic", "mortarTeamBipod", "mortarTeamTube"];
JK_classes = JK_USMC + JK_Para + JK_SpeczialClasses;
reverse JK_classes;
_fnc_gear_Call = {
    //[player, "test", {test}, {"test" == "test"}, [], 12, 12] call JK_Core_fnc_addAction;
    [_this ,"<t color='#00FF00'>USMC Gear</t>", {JK_Gear = "USMC"},  {JK_Gear == "Main"}, nil, 98, 3] call JK_Core_fnc_addAction;
    [_this, "<t color='#0011FF'>Paratrooper Gear</t>", {JK_Gear = "Para"},  {JK_Gear == "Main"}, nil, 97, 3] call JK_Core_fnc_addAction;
    [_this, "<t color='#F3FF00'>Crew/Special Gear</t>", {JK_Gear = "Spec"}, {JK_Gear == "Main"}, nil, 96, 3] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Back</t>", {JK_Gear = "Main"}, {JK_Gear != "Main"}, nil, 95, 3] call JK_Core_fnc_addAction;
    {
        private ["_string", "_cond", "_color"];
        _color = "00FF00";
        _cond = call {
            if (_x in JK_USMC) exitWith {_color = "00FF00";"JK_Gear == 'USMC'"};
            if (_x in JK_Para) exitWith {_color = "0011FF";"JK_Gear == 'Para'"};
            if (_x in JK_SpeczialClasses) exitWith {_color = "F3FF00";"JK_Gear == 'Spec'"};
            "true"
        };

        _string = (format ["STR_JK_GEAR_%1", toUpper _x]);
        if ( isLocalized (_string)) then { _string = localize _string; } else { _string = _x; };
        _string = (format["<t color='#%2'>%1</t>",_string, _color]);
        [_this, _string, {
            [player, _this select 3] call JK_loadOut_fnc_selectGear;
            JK_Gear = "Main";
        }, _cond, toLower _x, _foreachindex + 99, 3] call JK_Core_fnc_addAction;
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
