if (!hasInterface) exitWith {};

BG_BFT_Icons = [];
BG_BFT_onlyPlayer = false;

BG_BFT_iconTypes=[];

player setVariable ["BG_BFT_playerSide", playerSide, true];

["playerInventoryChanged", {
    private "_ctrl";
    _ctrl = uiNameSpace getVariable "BG_UI_BFT_ctrlGroup";
    if (!isNil "_ctrl" && {ctrlShown _ctrl}) then {
        call BG_fnc_bftdialog_editButton;
    };
    with uiNamespace do {
        BG_UI_BFT_editButton ctrlShow false;
    };
    _var = 0;
    if ("ACE_DAGR" in (Items player)) then {
        _var = 1;
    };
    if ("ACE_HuntIR_monitor" in (Items player)) then {
        _var = 2;
        with uiNamespace do {
            BG_UI_BFT_editButton ctrlShow true;
        };
    };
    player setVariable ["BG_BFT_item", _var, true];
}] call ace_common_fnc_addEventhandler;

private ["_keys", "_values", "_side"];
_keys = [];
_values = [];

BG_BFT_classes = "getText (_x >> 'markerClass') in ['NATO_BLUFOR', 'NATO_OPFOR', 'NATO_Independent']" configClasses (configfile >> "CfgMarkers");
uiNamespace setVariable ["BG_BFT_classes", BG_BFT_classes];
{
    _keys pushBack configName _x;
    _values pushBack [
    getText (_x >> "icon"),
    (_x >> "color") call BIS_fnc_colorConfigToRGBA,
    getNumber (_x >> "size"),
    getText (_x >> "name"),
    switch (getText (_x >> "markerClass")) do {
        case ("NATO_BLUFOR"): {
            west
        };
        case ("NATO_OPFOR"): {
            east
        };
        case ("NATO_Independent"): {
            independent
        };
    }];
} forEach BG_BFT_classes;

BG_BFT_iconTypes = [_keys,_values];

[] call BG_fnc_iconUpdateLoop;


[] spawn {
    waitUntil {!isNull ((findDisplay 12) displayCtrl 51)};
    [] call BG_fnc_bftdialog;
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",BG_fnc_drawEvent];
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["onLoad",{
        BG_BFT_PFHID = [{
            [] call BG_fnc_iconUpdateLoop;
        }, 10, []] call CBA_fnc_addPerFrameHandler;
        [] call BG_fnc_iconUpdateLoop;
    }];
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["onUnload",{
        private "_ctrl";
        _ctrl = uiNameSpace getVariable "BG_UI_BFT_ctrlGroup";
        if (!isNil "_ctrl" && {ctrlShown _ctrl}) then {
            call BG_fnc_bftdialog_editButton;
        };
        if (!isNil "BG_BFT_PFHID") then {
            [BG_BFT_PFHID] call CBA_fnc_removePerFrameHandler;
            BG_BFT_PFHID = nil;
        };
    }];
};
