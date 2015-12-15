/*
 * Author: joko // Jonas
 * Add Action for grabbing BFT
 *
 * Arguments:
 * 0: Unit <Object>
 *
 * Return Value:
 * None
 */
private ["_action", "_fnc_Check", "_fnc_Action"];

_fnc_Check = {
    params ["_target", "_caller"];
    (_caller getVariable ["BG_BFT_item", 0] == 0) &&
    (_target getVariable ["BG_BFT_item", 0] != 0)
};
_fnc_Action = {
    params ["_target", "_caller"];
    _caller setVariable ["BG_BTF_itemOld", player getVariable ["BG_BTF_item", 0]];
    _caller setVariable ["BG_BFT_item", 1];
    showMap true;
    [{
        params ["_args", "_idPFH"];
        _args params ["_target", "_caller"];
        if ((_target distance _caller) >= 3) then {
            _caller setVariable ["BG_BFT_item", _caller getVariable ["BG_BTF_itemOld", 0]];
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            _caller setVariable ["BG_BTF_itemOld", nil];
        };
    }, 0.2, [_target, _caller]] call CBA_fnc_addPerFrameHandler;
};

_action = ["BG_BFT_getUse", "Use BFT", "", _fnc_Action, _fnc_Check] call ace_interact_menu_fnc_createAction;
[_this select 0, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
