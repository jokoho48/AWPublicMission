disableSerialization;
private ["_map","_ctrl","_gY","_gX","_gY0","_gX0"];

with uiNamespace do {
    _gY = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
    _gX = (((safezoneW / safezoneH) min 1.2) / 40);

    _gY0 = SafeZoneY;
    _gX0 = SafeZoneX;

    _map = (findDisplay 12);


    BG_UI_BFT_editButton = _map ctrlCreate ["RscButton",-1];
    BG_UI_BFT_editButton ctrlSetPosition [_gX0+safeZoneW-19.5*_gX,_gY0+0.1*_gY,2.5*_gX,1.3*_gY];
    BG_UI_BFT_editButton ctrlSetText "ID";

    BG_UI_BFT_ctrlGroup  = _map ctrlCreate ["RscControlsGroupNoScrollbars",-1];
    BG_UI_BFT_ctrlGroup ctrlSetPosition [_gX0+safeZoneW-19.5*_gX,_gY0+1.4*_gY,13*_gX,6*_gY];
    BG_UI_BFT_ctrlGroup ctrlCommit 0;

    _ctrl = _map ctrlCreate ["RscBackground",-1,BG_UI_BFT_ctrlGroup];
    _ctrl ctrlSetPosition [0,0,13*_gX,6*_gY];
    _ctrl ctrlSetBackgroundColor [0,0,0,0.8];
    _ctrl ctrlCommit 0;

    _ctrl = _map ctrlCreate ["RscText",-1,BG_UI_BFT_ctrlGroup];
    _ctrl ctrlSetPosition [0.1*_gX,0.1*_gY,4.8*_gX,1*_gY];
    _ctrl ctrlSetText "Group Name:";
    _ctrl ctrlCommit 0;

    BG_UI_BFT_tbName = _map ctrlCreate ["RscEdit",-1,BG_UI_BFT_ctrlGroup];
    BG_UI_BFT_tbName ctrlSetPosition [5*_gX,0.2*_gY,7.9*_gX,1*_gY];
    BG_UI_BFT_tbName ctrlCommit 0;

    BG_UI_BFT_lbIcon = _map ctrlCreate ["RscListBox",-1,BG_UI_BFT_ctrlGroup];
    BG_UI_BFT_lbIcon ctrlSetPosition [0.2*_gX,1.4*_gY,12.6*_gX,4.4*_gY];
    BG_UI_BFT_lbIcon ctrlCommit 0;

    BG_UI_BFT_ctrlGroup ctrlShow false;
};

BG_fnc_bftdialog_editButton = {
    disableSerialization;
        with uiNamespace do {
        _defaultIcon = switch (playerSide) do {
            case (west): {
                "b_unknown"
            };
            case (east): {
                "o_unknown"
            };
            case (independent) :{
                "n_unknown"
            };
            default {
                "hd_unknown"
            };
        };
        if (ctrlShown BG_UI_BFT_ctrlGroup) then {
            BG_UI_BFT_ctrlGroup ctrlShow false;
            BG_UI_BFT_editButton ctrlSetText "ID";
            group player setGroupIdGlobal [ctrlText BG_UI_BFT_tbName];
            group player setVariable ["BG_BFT_groupId", ctrlText BG_UI_BFT_tbName,true];
            group player setVariable ["BG_BFT_icon", (BG_UI_BFT_lbIcon lbData lbCurSel BG_UI_BFT_lbIcon),true];

            BG_UI_BFT_ctrlGroup ctrlCommit 0;
            BG_UI_BFT_editButton ctrlCommit 0;
        } else {
            BG_UI_BFT_ctrlGroup ctrlShow true;
            BG_UI_BFT_editButton ctrlSetText "EDIT";
            lbClear BG_UI_BFT_lbIcon;

            {
                private ["_name", "_tmp"];
                _name = _x select 5;

                if ((_x select 4) == playerSide) then {
                    _tmp = BG_UI_BFT_lbIcon lbAdd (_x select 3);
                    BG_UI_BFT_lbIcon lbSetPicture [_tmp, _x select 0];
                    BG_UI_BFT_lbIcon lbSetPictureColor [_tmp, _x select 1];
                    BG_UI_BFT_lbIcon lbSetData [_tmp, _name];

                    if (_name == ((group player) getVariable ["BG_BFT_icon",_defaultIcon])) then {
                        BG_UI_BFT_lbIcon lbSetCurSel _tmp;
                    };
                };

            } forEach ((missionNamespace getVariable ["BG_BFT_iconTypes",[[],[]]]) select 1);

            BG_UI_BFT_lbIcon ctrlCommit 0;

            BG_UI_BFT_tbName ctrlSetText ((group player) getVariable ["BG_BFT_groupId", (groupId (group player))]);
            BG_UI_BFT_tbName ctrlCommit 0;

            BG_UI_BFT_ctrlGroup ctrlCommit 0;
            BG_UI_BFT_editButton ctrlCommit 0;
        };
    };
    [] call BG_fnc_iconUpdateLoop;
};
with uiNamespace do {
    BG_UI_BFT_editButton ctrlAddEventHandler ["ButtonClick", missionNamespace getVariable "BG_fnc_bftdialog_editButton"];
    BG_UI_BFT_editButton ctrlCommit 0;
};
