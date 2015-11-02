disableSerialization;
params ['_ctrl', '_xPos', '_yPos'];
private ['_r','_temp','_group','_pos'];
if (0<count BG_BFT_icons) then {
    _r = 1000;
    {
        _pos = _ctrl ctrlMapWorldToScreen visiblePosition (_x select 2);
        _temp = sqrt ((_xPos-(_pos select 0))^2+(_yPos-(_pos select 1))^2);
        if (_temp < _r) then {
            _r = _temp;
            _group = _x;
        };
    } forEach BG_BFT_icons;

    if (_r < 0.02) then {
        (uiNamespace getVariable "BG_UI_BFT_ttRadio") ctrlSetText ((group (_group select 2)) getVariable ["BG_BFT_radioInfo","SR: ??; LR: ??"]);
        (uiNamespace getVariable "BG_UI_BFT_ttRadio") ctrlCommit 0;
        (uiNamespace getVariable "BG_UI_BFT_ttRemarks") ctrlSetText ((group (_group select 2)) getVariable ["BG_BFT_remarks",""]);
        (uiNamespace getVariable "BG_UI_BFT_ttRemarks") ctrlCommit 0;
        (uiNamespace getVariable "BG_UI_BFT_groupToolTip") ctrlSetPosition [_xPos,_yPos];
        (uiNamespace getVariable "BG_UI_BFT_groupToolTip") ctrlShow true;
        (uiNamespace getVariable "BG_UI_BFT_groupToolTip") ctrlCommit 0;
    } else {
        with uiNamespace do {
            BG_UI_BFT_groupToolTip ctrlShow false;
            BG_UI_BFT_groupToolTip ctrlCommit 0;
        };
    };
};
