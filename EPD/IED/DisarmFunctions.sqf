/* original work from: Tankbuster */
/* adapted from:  Dynamic IED script by - Mantis -*/
/* Rewritten by Brian Sweeney - [EPD] Brian*/

DISARM_ADD_ACTION = {
    private ["_iedArray"];
    params ["_sectionName", "_iedName"];

    _iedArray = [_sectionName, _iedName] call GET_IED_ARRAY;

    _itemRequirement = "(vehicle player == player)";
    {
        _itemRequirement = format["%1 && ((items player) find ""%2"" > -1)", _itemRequirement, _x];
        nil
    } count itemsRequiredToDisarm;

    //_action = ['JK_IED','Defuse IED','',{_this spawn DISARM_ACTION}, _itemRequirement, {}, [_iedArray,[_sectionName, _iedName]]] call ace_interact_menu_fnc_createAction;
    //[(_iedArray select 0), 1, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    [(_iedArray select 0), "<t color=""#27EE1F"">Disarm</t>", DISARM_ACTION, _itemRequirement, [_iedArray,[_sectionName, _iedName]], 3, 3] call JK_Core_fnc_addAction;
    //(_iedArray select 0) addAction [("<t color=""#27EE1F"">") + ("Disarm") + "</t>", DISARM_ACTION, [_iedArray,[_sectionName, _iedName]], 10, false, true, "", _itemRequirement];
};

DISARM_ACTION = {
    params ["", "", "", "_params"];
    _params params ["_iedArray", "_args"];
    _args params ["_sectionName", "_sectionName"];

    //deleteVehicle (_iedArray select 1); //deleting the trigger
    //(_iedArray select 0) removeaction 0; //remove the disarm addaction
    deleteMarker (_iedArray select 4); //remove the map marker
    //hint "disarmed!";

    _chance = baseDisarmChance;
    hint "start Disarming";
    if (((random 100) < _chance)) then {
        //Acts_carFixingWheel --- would like to use this, but it doesn't seem to work...
        [[player, {_this playmovenow "AinvPknlMstpSnonWrflDr_medic4";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
        disableUserInput true;
        sleep 4.545;
        [[player, {_this playmove "AinvPknlMstpSnonWrflDr_medic3";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
        sleep 6.545;
        disableUserInput false;
        [_iedArray select 0,"REMOVE_DISARM_ACTION", true, false] spawn BIS_fnc_MP;
        _this select 3 select 1 select 0 call INCREMENT_DISARM_COUNTER;
        _this select 3 select 1 call PREPARE_IED_FOR_CLEANUP;
        hint "Successfully Disarmed!";
        publicVariable "iedDictionary";
    } else {
        //Acts_carFixingWheel --- would like to use this, but it doesn't seem to work...
        [[player, {_this playmovenow "AinvPknlMstpSnonWrflDr_medic4";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
        disableUserInput true;
        sleep 4.545;
        disableUserInput false;
        _this select 3 select 1 select 0 call INCREMENT_EXPLOSION_COUNTER;
        _this select 3 select 1 call EXPLOSIVESEQUENCE_DISARM;
        hint "Failed to Disarm!";
        //publicVariable "iedDictionary";          //not needed as the explosion will update
    };
    (_iedArray select 0) removeAllEventHandlers "HitPart";
    JK_IED deleteAt (JK_IED find (_iedArray select 0));
    terminate (_iedArray select 5);
};

REMOVE_DISARM_ACTION = {
    //[_this, 0, ["ACE_TapShoulderRight","VulcanPinch"]] call ace_interact_menu_fnc_removeActionFromObject;
    _this removeAction 0;
};
