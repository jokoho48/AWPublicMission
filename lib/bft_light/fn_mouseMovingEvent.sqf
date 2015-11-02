if (player getVariable ["BG_BFT_item", 0] == 0) exitWith {
    with uiNamespace do {
        BG_UI_BFT_groupToolTip ctrlShow false;
        BG_UI_BFT_groupToolTip ctrlCommit 0;
    };
};

disableSerialization;
params ['_ctrl', '_xPos', '_yPos'];
private ['_r','_temp','_group','_pos'];
if !(BG_BFT_icons isEqualTo []) then {
    _r = 1000;
    {
        _pos = _ctrl ctrlMapWorldToScreen visiblePosition (_x select 2);
        _temp = sqrt ((_xPos-(_pos select 0))^2+(_yPos-(_pos select 1))^2);
        if (_temp < _r) then {
            _r = _temp;
            _group = _x;
        };
    } count BG_BFT_icons;

    if (_r < 0.02) then {
        with uiNamespace do {
            BG_UI_BFT_ttRadio ctrlSetText ((group (_group select 2)) getVariable ["BG_BFT_radioInfo","SR: n/a; LR: n/a"]);
            BG_UI_BFT_ttRadio ctrlCommit 0;
            BG_UI_BFT_ttRemarks ctrlSetText ((group (_group select 2)) getVariable ["BG_BFT_remarks",""]);
            BG_UI_BFT_ttRemarks ctrlCommit 0;
            BG_UI_BFT_groupToolTip ctrlSetPosition [_xPos,_yPos];
            BG_UI_BFT_groupToolTip ctrlShow true;
            BG_UI_BFT_groupToolTip ctrlCommit 0;
        };
    } else {
        with uiNamespace do {
            BG_UI_BFT_groupToolTip ctrlShow false;
            BG_UI_BFT_groupToolTip ctrlCommit 0;
        };
    };
};
