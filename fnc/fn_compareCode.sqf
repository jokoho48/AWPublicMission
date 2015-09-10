//Parameters
private ["_code","_inputCode","_compare"];

_code      = _this select 0;
_inputCode = _this select 1;

//compare codes
_compare = [_code, _inputCode] call BIS_fnc_areEqual;

if (_compare) then {
	["<t size='0.6'>EXPLOSIVES DEFUSED</t>"] spawn bis_fnc_dynamicText;
	SEN_defused = true; publicVariableServer "SEN_defused";
} else {
	["<t size='0.6'>EXPLOSIVES ARMED</t>"] spawn bis_fnc_dynamicText;
	SEN_armed = true; publicVariableServer "SEN_armed";
};

SEN_codeInput = [];

//Return Value
_code