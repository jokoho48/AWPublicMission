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

JK_classes = ["Command","Leader","Medic","ARMan","MG","AssMG","At","ATmk153","AtAss","ATAssmk153","Grenadier","Rifleman","paratrooper","paraARman","paraDropMedic","paraExExpert","paraGrenadier","paraLeader","paraMarksman","stormtrooper","Marksman","Specialist","Pilot","Crew","jetPilot","pjMedic"];
reverse JK_classes;
_fnc_gear_Call = {
    {
        private "_string";
        _string = (format ["STR_JK_GEAR_%1", toUpper _x]);
        if ( isLocalized (_string)) then { _string = localize _string; } else { _string = _x; };
        _string = (format["<t color=""#00FF00"">%1</t>",_string]);
        _this addAction [_string, {
            [player, _this select 3] call JK_loadOut_fnc_selectGear;
        }, toLower _x, _foreachindex, false, true, "", "true"];
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
