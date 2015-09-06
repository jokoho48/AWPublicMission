private ["_textValue", "_listboxCtrl", "_sel"];

params [["_varType", "", [""]], ["_textCtrl", controlNull, [0, controlNull]], ["_listbox", controlNull, [0, controlNull]]];

_textValue = [ctrlText _textCtrl, "0123456789."] call BIS_fnc_filterString;
_textValue = if (_textValue == "") then {50} else {((call compile _textValue) min 50) max 3.125};


if (!CHVD_allowNoGrass) then {
    _textValue = _textValue min 48.99;
};

//update listbox
_listboxCtrl = (finddisplay 2900) displayCtrl _listbox;
//remove EH not to cause huge lag
_listboxCtrl ctrlRemoveAllEventHandlers "LBSelChanged";
_sel = [_textValue] call CHVD_fnc_selTerrainQuality;
if (CHVD_allowNoGrass) then {
    _listboxCtrl lbSetCurSel _sel;
} else {
    _listboxCtrl lbSetCurSel (_sel - 1);
};
//add EH again
_listboxCtrl ctrlSetEventHandler ["LBSelChanged",
    format ["[_this select 1, '%1', %2] call CHVD_fnc_onLBSelChanged", _varType, _textCtrl]
];

//ctrlSetText [_textCtrl, str _textValue];
missionNamespace setVariable [_vartype, _textValue];
profileNamespace setVariable [_varType, _textValue];

[] call CHVD_fnc_updateTerrain;
