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
JK_USMC = ["MC_Command", "MC_radioOp", "MC_Leader", "MC_FTL", "MC_Medic", "MC_ARMan", "MC_MG", "MC_AssMG", "MC_AA", "MC_AAAss", "MC_At", "MC_ATmk153", "MC_AtAss", "MC_ATAssmk153", "MC_Grenadier", "MC_Rifleman", "MC_stormtrooper", "MC_Marksman", "MC_Specialist"];
JK_USARMY = ["AR_Command", "AR_radioOp", "AR_Leader", "AR_FTL", "AR_Medic", "AR_ARMan", "AR_MG", "AR_AssMG", "AR_AA", "AR_AAAss", "AR_At", "AR_ATmk153", "AR_AtAss", "AR_ATAssmk153", "AR_Grenadier", "AR_Rifleman", "AR_stormtrooper", "AR_Marksman", "AR_Specialist"];
JK_USSOF = ["SO_leader", "SO_grenadier", "SO_AT", "SO_ARman", "SO_marksman", "SO_SpecOps","SO_AA", "SO_specialist"];
JK_USSOFlight = ["SOL_leader", "SOL_AT", "SOL_ARman", "SOL_grenadier", "SOL_marksman", "SOL_specialist", "SOL_SpecOps", "SOL_AA"];
JK_Para = ["PARA_Leader", "PARA_trooper", "PARA_ARman", "PARA_DropMedic", "PARA_ExExpert", "PARA_Grenadier", "PARA_Marksman", "PARA_Stormtrooper", "PARA_AssAR"];
JK_SpeczialClasses = ["MC_mortarTeamBipod", "MC_mortarTeamTube", "AR_m2TeamTripod", "pjMedic", "AR_m2TeamGun", "Pilot", "jetPilot", "Crew"];
JK_classes = JK_USMC + JK_USARMY + JK_USSOF + JK_USSOFlight + JK_Para + JK_SpeczialClasses;
reverse JK_classes;
_fnc_gear_Call = {
    //[player, "test", {test}, {"test" == "test"}, [], 12, 12] call JK_Core_fnc_addAction;
    [_this ,"<t color='#52c652'>USMC Gear</t>", {JK_Gear = "USMC"},  {JK_Gear == "Main"}, nil, 98, 3] call JK_Core_fnc_addAction;
    [_this ,"<t color='#c6c6c6'>USARMY Gear</t>", {JK_Gear = "USARMY"},  {JK_Gear == "Main"}, nil, 98, 3] call JK_Core_fnc_addAction;
    [_this ,"<t color='#fa6bff'>USSOF heavy Gear</t>", {JK_Gear = "USSOF"},  {JK_Gear == "Main"}, nil, 98, 3] call JK_Core_fnc_addAction;
    [_this ,"<t color='#e1b10a'>USSOF light Gear</t>", {JK_Gear = "USSOFlight"},  {JK_Gear == "Main"}, nil, 98, 3] call JK_Core_fnc_addAction;
    [_this, "<t color='#7f7fff'>Paratrooper Gear</t>", {JK_Gear = "Para"},  {JK_Gear == "Main"}, nil, 97, 3] call JK_Core_fnc_addAction;
    [_this, "<t color='#f9ea6b'>Crew/Special Gear</t>", {JK_Gear = "Spec"}, {JK_Gear == "Main"}, nil, 96, 3] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Back</t>", {JK_Gear = "Main"}, {JK_Gear != "Main"}, nil, 95, 3] call JK_Core_fnc_addAction;
    {
        private ["_string", "_cond", "_color"];
        _color = "52c652";
        _cond = call {
            if (_x in JK_USMC) exitWith {_color = "52c652";"JK_Gear == 'USMC'"};
            if (_x in JK_USARMY) exitWith {_color = "c6c6c6";"JK_Gear == 'USARMY'"};
            if (_x in JK_USSOF) exitWith {_color = "fa6bff";"JK_Gear == 'USSOF'"};
            if (_x in JK_USSOFlight) exitWith {_color = "e1b10a";"JK_Gear == 'USSOFlight'"};
            if (_x in JK_Para) exitWith {_color = "7f7fff";"JK_Gear == 'Para'"};
            if (_x in JK_SpeczialClasses) exitWith {_color = "f9ea6b";"JK_Gear == 'Spec'"};
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
