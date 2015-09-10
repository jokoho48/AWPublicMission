/*
Author: SENSEI

Last modified: 8/14/2015

Description:  handles fob control requests
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_package","_requestor","_response","_addons","_addonsVeh","_userName"];

_package = _this select 0;
if (count _package isEqualTo 1) exitWith {
    [[_package select 0],"SEN_fnc_fobReceiveRequest",owner (getAssignedCuratorUnit SEN_curatorFOB)] call BIS_fnc_MP;
};

_requestor = _package select 0;
_response = _package select 1;
_userName = "SERVER";
if !(isNull (getAssignedCuratorUnit SEN_curatorFOB)) then {
    _userName = name (getAssignedCuratorUnit SEN_curatorFOB);
};

if (_response isEqualTo 1) then {
    _addons = ["A3_Structures_F_Mil_Cargo","A3_Structures_F_Mil_Fortification","A3_Structures_F_Mil_Helipads","A3_Structures_F_Mil_Shelters","A3_Structures_F_Civ_Lamps","A3_Structures_F_Mil_BagBunker","A3_Structures_F_Mil_BagFence","A3_Structures_F_Civ_Camping","ace_medical"];
    _addonsVeh = ["rhsusf_c_hmmwv","A3_Soft_F_MRAP_01","A3_Soft_F_HEMTT"];
    if (count (["CamoNet_BLUFOR_big_Curator_F", "CamoNet_OPFOR_big_Curator_F", "CamoNet_INDP_big_Curator_F"] arrayIntersect (curatorEditableObjects SEN_curatorFOB)) > 0) then {
        _addons = _addons + _addonsVeh;
    };
    SEN_curatorFOBUnitUID = "";
    (owner (getAssignedCuratorUnit SEN_curatorFOB)) publicVariableClient "SEN_curatorFOBUnitUID";
    unassignCurator SEN_curatorFOB;
    sleep 1;
    _requestor assignCurator SEN_curatorFOB;
    waitUntil {sleep 0.1; !(isNull (getAssignedCuratorUnit SEN_curatorFOB))};
    SEN_curatorFOBUnitUID = getPlayerUID _requestor;
    (owner _requestor) publicVariableClient "SEN_curatorFOBUnitUID";
    SEN_curatorFOB addCuratorAddons _addons; // new curator user doesn't get all addons sometimes, this fixes issue
    [(curatorEditableObjects SEN_curatorFOB),owner (getAssignedCuratorUnit SEN_curatorFOB)] call SEN_fnc_setOwner; // need to set locality to new user, otherwise non local objects lag when edited
};
[[_userName,_response],"SEN_fnc_fobAnswerRequest",owner _requestor] call BIS_fnc_MP;