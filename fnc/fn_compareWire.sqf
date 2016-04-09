//Parameters
params ["_wire","_cutWire"];

if (_wire isEqualTo _cutWire) then {
    ["<t size='0.6'>EXPLOSIVES DEFUSED</t>"] spawn bis_fnc_dynamicText;
    SEN_defused = true; publicVariableServer "SEN_defused";
} else {
    ["<t size='0.6'>EXPLOSIVES ARMED</t>"] spawn bis_fnc_dynamicText;
    SEN_armed = true; publicVariableServer "SEN_armed";
};

//Return Value
_wire
