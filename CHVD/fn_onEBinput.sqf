private ["_textValue","_updateType"];
params [
    ["_varType1", "", [""]],
    ["_slider1", controlNull, [0, controlNull]],
    ["_text1", controlNull, [0, controlNull]],
    ["_varType2", "", [""]],
    ["_slider2", controlNull, [0, controlNull]],
    ["_text2", controlNull, [0, controlNull]],
    ["_syncVar", "", [""]]
];

if (count _this < 7) then {
    _updateType = 2;
} else {
    if (call compile _syncVar) then {
        _updateType = 3;
    } else {
        _updateType = 1;
    };
};

switch (_updateType) do {
    case 1: {
        _textValue = [ctrlText _text1, "0123456789"] call BIS_fnc_filterString;
        _textValue = if (_textValue == "") then {0} else {call compile _textValue min 12000 max 0};

        sliderSetPosition [_slider1, _textValue min CHVD_maxView];
        //ctrlSetText [_text1, str round (_textValue min CHVD_maxView)];
        sliderSetRange [_slider2, 0, _textValue min CHVD_maxView];
        missionNameSpace setVariable [_varType1, _textValue min CHVD_maxView];
        profileNamespace setVariable [_varType1, _textValue min CHVD_maxView];

        if ((call compile _varType2) > _textValue) then {
            sliderSetPosition [_slider2, _textValue min CHVD_maxObj];
            ctrlSetText [_text2, str round (_textValue min CHVD_maxObj)];
            missionNameSpace setVariable [_varType2, _textValue min CHVD_maxObj];
            profileNamespace setVariable [_varType2, _textValue min CHVD_maxObj];
        };

        [_updateType] call CHVD_fnc_updateSettings;
    };
    case 2: {
        _textValue = [ctrlText _text1, "0123456789"] call BIS_fnc_filterString;
        _textValue = if (_textValue == "") then {0} else {call compile _textValue min 12000 max 0};

        sliderSetPosition [_slider1, _textValue min CHVD_maxObj];
        //ctrlSetText [_text1, str round (_textValue min CHVD_maxObj)];
        missionNamespace setVariable [_varType1, _textValue min CHVD_maxObj];
        profileNamespace setVariable [_varType1, _textValue min CHVD_maxObj];

        [_updateType] call CHVD_fnc_updateSettings;
    };
    case 3: {
        _textValue = [ctrlText _text1, "0123456789"] call BIS_fnc_filterString;
        _textValue = if (_textValue == "") then {0} else {call compile _textValue min 12000 max 0};

        sliderSetPosition [_slider1, _textValue min CHVD_maxView];
        //ctrlSetText [_text1, str round (_textValue min CHVD_maxView)];
        sliderSetRange [_slider2, 0, _textValue min CHVD_maxView];

        missionNamespace setVariable [_varType1, _textValue min CHVD_maxView];
        profileNamespace setVariable [_varType1, _textValue min CHVD_maxView];

        if ((call compile _varType2) > _textValue) then {
            sliderSetPosition [_slider2, _textValue min CHVD_maxObj];
            ctrlSetText [_text2, str round (_textValue min CHVD_maxObj)];

            missionNamespace setVariable [_varType2, _textValue min CHVD_maxObj];
            profileNamespace setVariable [_varType2, _textValue min CHVD_maxObj];
        };

        sliderSetPosition [_slider2, _textValue min CHVD_maxObj];
        ctrlSetText [_text2, str round (_textValue min CHVD_maxObj)];

        missionNamespace setVariable [_varType2, _textValue min CHVD_maxObj];
        profileNamespace setVariable [_varType2, _textValue min CHVD_maxObj];

        [_updateType] call CHVD_fnc_updateSettings;
    };
};
