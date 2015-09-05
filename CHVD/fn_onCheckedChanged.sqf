params [
    ["_state", 0, [0]],
    ["_syncVar", "", [""]],
    ["_slider", controlNull, [0 ,controlNull]],
    ["_text", controlNull, [0, controlNull]],
    ["_sliderView", controlNull, [0,controlNull]],
    ["_varType", "", [""]]
];
if (_state == 1) then {
    missionNameSpace setVariable [_syncVar, true];
    profileNamespace setVariable [_syncVar, true];
    ctrlEnable [_slider, false];
    ctrlEnable [_text, false];

    ctrlSetText [_text, str round ((sliderPosition _sliderView) min CHVD_maxObj)];
    sliderSetPosition [_slider, (sliderPosition _sliderView) min CHVD_maxObj];

    missionNamespace setVariable [_varType, (sliderPosition _sliderView) min CHVD_maxObj];
    profileNamespace setVariable [_varType, missionNamespace getVariable _varType];
    [3] call CHVD_fnc_updateSettings;
} else {
    missionNameSpace setVariable [_syncVar, false];
    profileNamespace setVariable [_syncVar, false];
    ctrlEnable [_slider, true];
    ctrlEnable [_text, true];
};
