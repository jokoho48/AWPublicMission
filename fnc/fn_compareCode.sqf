//Parameters
private ["_code","_inputCode","_compare"];
params ["_code", "_inputCode"];

if (_code isEqualTo _inputCode) then {
    ["<t size='0.6'>EXPLOSIVES DEFUSED</t>"] spawn bis_fnc_dynamicText;
    SEN_defused = true; publicVariableServer "SEN_defused";
} else {
    ["<t size='0.6'>EXPLOSIVES ARMED</t>"] spawn bis_fnc_dynamicText;
    SEN_armed = true; publicVariableServer "SEN_armed";
};

SEN_codeInput = [];

//Return Value
_code
