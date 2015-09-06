
if (!createDialog "CHVD_dialog") exitWith {systemChat "Error: Can't open 'CH View Distance' dialog."};
disableSerialization;

{
    ctrlSetText _x;
} forEach [[1006, str round CHVD_foot],[1007, str round CHVD_footObj],[1013, str round CHVD_car],[1014, str round CHVD_carObj],[1017, str round CHVD_air],[1018, str round CHVD_airObj],[1400, str CHVD_footTerrain],[1401, str CHVD_carTerrain],[1402, str CHVD_airTerrain]];

{
    _x params ["_idcVD", "_currentVD", "_maxVD", "_idcObj", "_currentObj", "_maxObj"];
    sliderSetRange [_idcVD, 0, _maxVD];
    sliderSetRange [_idcObj, 0, _maxObj min (_currentVD)];
    sliderSetSpeed [_idcVD, 500, 500];
    sliderSetSpeed [_idcObj, 500, 500];
    sliderSetPosition [_idcVD, _currentVD];
    sliderSetPosition [_idcObj, _currentObj min (_currentVD)];
} forEach [[1900,CHVD_foot,CHVD_maxView,1901,CHVD_footObj,CHVD_maxObj],[1902,CHVD_car,CHVD_maxView,1903,CHVD_carObj,CHVD_maxObj],[1904,CHVD_air,CHVD_maxView,1905,CHVD_airObj,CHVD_maxObj]];

{
    ((finddisplay 2900) displayCtrl (_x select 0)) cbSetChecked (_x select 1);
} forEach [[2800,CHVD_footSyncObj],[2801,CHVD_carSyncObj],[2802,CHVD_airSyncObj]];

{
    private ["_ctrl", "_textStandard", "_textHigh", "_textVeryHigh", "_sel"];
    _ctrl = ((finddisplay 2900) displayCtrl (_x select 0));
    if (CHVD_allowNoGrass) then {
        _textLow = if (isLocalized "STR_chvd_low") then {localize "STR_chvd_low"} else {"Low"};
        _ctrl lbAdd _textLow;
    };
    _textStandard = if (isLocalized "STR_chvd_standard") then {localize "STR_chvd_standard"} else {"Standard"};
    _ctrl lbAdd _textStandard;
    _textHigh = if (isLocalized "STR_chvd_high") then {localize "STR_chvd_high"} else {"High"};
    _ctrl lbAdd _textHigh;
    _textVeryHigh = if (isLocalized "STR_chvd_veryHigh") then {localize "STR_chvd_veryHigh"} else {"Very High"};
    _ctrl lbAdd _textVeryHigh;

    _sel = [_x select 1] call CHVD_fnc_selTerrainQuality;
    if (CHVD_allowNoGrass) then {
        _ctrl lbSetCurSel _sel;
    } else {
        _ctrl lbSetCurSel (_sel - 1);
    };
} forEach [[1500,CHVD_footTerrain],[1501,CHVD_carTerrain],[1502,CHVD_airTerrain]];

{
    private ["_ctrl", "_handle"];
    _ctrl = ((finddisplay 2900) displayCtrl (_x select 0));
    _handle = _ctrl ctrlSetEventHandler ["LBSelChanged",
        format ["[_this select 1, '%1', %2] call CHVD_fnc_onLBSelChanged", _x select 1, _x select 2]
    ];
} forEach [[1500,"CHVD_footTerrain",1400],[1501,"CHVD_carTerrain",1401],[1502,"CHVD_airTerrain",1402]];


if (CHVD_footSyncObj) then {
    ctrlEnable [1901,false];
    ctrlEnable [1007,false];
} else {
    ctrlEnable [1901,true];
    ctrlEnable [1007,true];
};

if (CHVD_carSyncObj) then {
    ctrlEnable [1903,false];
    ctrlEnable [1014,false];
} else {
    ctrlEnable [1903,true];
    ctrlEnable [1014,true];
};

if (CHVD_airSyncObj) then {
    ctrlEnable [1905,false];
    ctrlEnable [1018,false];
} else {
    ctrlEnable [1905,true];
    ctrlEnable [1018,true];
};
