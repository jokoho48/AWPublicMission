private ["_sliderPos","_updateType"];

params [
    ["_varType1", "", [""]],
    ["_slider1", 0, [0, controlNull]],
    ["_sliderPos", 0, [0]],
    ["_text1", 0, [0, controlNull]],
    ["_varType2", "", [""]],
    ["_slider2", 0, [0, controlNull]],
    ["_text2", 0, [0, controlNull]],
    ["_syncVar", "", [""]]
];

_slider1 = ctrlIDC _slider1;
if (count _this < 8) then {
    _updateType = 2;
} else {
    if (missionNamespace getVariable [_syncVar, false]) then {
        _updateType = 3;
    } else {
        _updateType = 1;
    };
};

switch (_updateType) do {
    case 1: {
        sliderSetPosition [_slider1, _sliderPos min CHVD_maxView];
        ctrlSetText [_text1, str round (_sliderPos min CHVD_maxView)];
        sliderSetRange [_slider2, 0, _sliderPos min CHVD_maxView];
        missionNamespace setVariable [_varType1, value, public]
        call compile format ["%1 = %2", _varType1, _sliderPos min CHVD_maxView];
        call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];

        if ((call compile _varType2) > _sliderPos) then {
            sliderSetPosition [_slider2, _sliderPos min CHVD_maxObj];
            ctrlSetText [_text2, str round (_sliderPos min CHVD_maxObj)];

            call compile format ["%1 = %2", _varType2, _sliderPos min CHVD_maxObj];
            call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
        };

        [_updateType] call CHVD_fnc_updateSettings;
    };
    case 2: {
        sliderSetPosition [_slider1, _sliderPos min CHVD_maxObj];
        ctrlSetText [_text1, str round (_sliderPos min CHVD_maxObj)];

        call compile format ["%1 = %2", _varType1, _sliderPos min CHVD_maxObj];
        call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];

        [_updateType] call CHVD_fnc_updateSettings;
    };
    case 3: {
        sliderSetPosition [_slider1, _sliderPos min CHVD_maxView];
        ctrlSetText [_text1, str round (_sliderPos min CHVD_maxView)];
        sliderSetRange [_slider2, 0, _sliderPos min CHVD_maxView];

        call compile format ["%1 = %2", _varType1, _sliderPos min CHVD_maxView];
        call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];

        if ((call compile _varType2) > _sliderPos) then {
            sliderSetPosition [_slider2, _sliderPos min CHVD_maxObj];
            ctrlSetText [_text2, str round (_sliderPos min CHVD_maxObj)];

            call compile format ["%1 = %2", _varType2, _sliderPos min CHVD_maxObj];
            call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
        };

        sliderSetPosition [_slider2, _sliderPos min CHVD_maxObj];
        ctrlSetText [_text2, str round (_sliderPos min CHVD_maxObj)];

        call compile format ["%1 = %2", _varType2, _sliderPos min CHVD_maxObj];
        call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];

        [_updateType] call CHVD_fnc_updateSettings;
    };
};
