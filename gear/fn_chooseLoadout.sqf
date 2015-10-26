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
JK_USMC = ["Command","Leader","Medic","ARMan","MG","AssMG","At","ATmk153","AtAss","ATAssmk153","Grenadier","Rifleman","stormtrooper","Marksman","Specialist","radioOp"];
JK_Para = ["paratrooper","paraARman","paraDropMedic","paraExExpert","paraGrenadier","paraLeader","paraMarksman","paraStormtrooper","paraAssAR","paraSpecOps"];
JK_SpeczialClasses = ["Pilot","Crew","jetPilot","pjMedic","SpecOps"];
JK_classes = JK_USMC + JK_Para + JK_SpeczialClasses;
reverse JK_classes;
_fnc_gear_Call = {
    _this addAction ["<t color=""#00FF00"">USMC Gear</t>", {JK_Gear = "USMC"}, [], 99, false, false, "", "(_target distance _this < 3) && JK_Gear == 'Main'"];
    _this addAction ["<t color=""#0011FF"">Paratrooper Gear</t>", {JK_Gear = "Para"}, [], 99, false, false, "", "(_target distance _this < 3) && JK_Gear == 'Main'"];
    _this addAction ["<t color=""#F3FF00"">Crew/Special Gear</t>", {JK_Gear = "Spec"}, [], 99, false, false, "", "(_target distance _this < 3) && JK_Gear == 'Main'"];
    _this addAction ["<t color=""#AE2020"">Back</t>", {JK_Gear = "Main"}, [], 0, false, false, "", "(_target distance _this < 3) && JK_Gear != 'Main'"];
    {
        private ["_string", "_cond", "_color"];
        _color = "00FF00";
        _cond = "(_target distance _this < 3) && " + call {
            if (_x in JK_USMC) exitWith {_color = "00FF00";"JK_Gear == 'USMC'"};
            if (_x in JK_Para) exitWith {_color = "0011FF";"JK_Gear == 'Para'"};
            if (_x in JK_SpeczialClasses) exitWith {_color = "F3FF00";"JK_Gear == 'Spec'"};
            "true"
        };

        _string = (format ["STR_JK_GEAR_%1", toUpper _x]);
        if ( isLocalized (_string)) then { _string = localize _string; } else { _string = _x; };
        _string = (format["<t color=""#%2"">%1</t>",_string, _color]);
        _this addAction [_string, {
            [player, _this select 3] call JK_loadOut_fnc_selectGear;
            JK_Gear = "Main";
        }, toLower _x, _foreachindex + 1, false, true, "", _cond];
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
