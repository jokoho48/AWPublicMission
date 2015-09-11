//Parameters
private "_compare";
params ["_wire","_cutWire"];

//compare wires
_compare = [_wire, _cutWire] call BIS_fnc_areEqual;

if (_compare) then {
    ["<t size='0.6'>EXPLOSIVES DEFUSED</t>"] spawn bis_fnc_dynamicText;
    SEN_defused = true; publicVariableServer "SEN_defused";
} else {
    ["<t size='0.6'>EXPLOSIVES ARMED</t>"] spawn bis_fnc_dynamicText;
    SEN_armed = true; publicVariableServer "SEN_armed";
};

//Return Value
_wire
