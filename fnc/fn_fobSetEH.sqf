/*
Author: SENSEI

Last modified: 8/5/2015

Description: set curator event handler. run on player only

        returns nothing
__________________________________________________________________*/
(_this select 0) addEventHandler ["CuratorObjectPlaced",{
    params ["_zeus", "_object"];
    if (typeOf _object in ["Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F"]) then {
        _object setvariable ["ace_medical_isMedicalFacility", true, true];
    };
    if (typeOf _object in ["CamoNet_BLUFOR_big_Curator_F", "CamoNet_OPFOR_big_Curator_F", "CamoNet_INDP_big_Curator_F"]) then {
        hintSilent "Vehicle cover deployed. You can spawn vehicles now.";
        [[_zeus,["rhsusf_c_hmmwv","A3_Soft_F_MRAP_01","A3_Soft_F_HEMTT"]],"SEN_fnc_fobAddAddon",false] call BIS_fnc_MP;
    };
}];
