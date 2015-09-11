/*
Author: SENSEI, Eightysix

Last modified: 7/23/2015

Description: sets param code

         returns boolean
__________________________________________________________________*/
private["_pname","_pval","_pcode","_var","_requireBoolean"];

//_requireBoolean = ["ace_map_BFT_Enabled = %1;", "ace_medical_enableAdvancedWounds = %1;", "ace_advanced_ballistics_enabled = %1;"];
{
    _pname = configName ((missionConfigFile >> "Params") select _ForEachIndex);
    _pCode = getText (missionConfigFile >> "Params" >> _pname >> "SEN_paramCode");
    _pval = paramsArray select _ForEachIndex;
    //if (_pCode in _requireBoolean) then {_pval = if (_pval isEqualTo 0) then {false} else {true}};
    _var = format[_pCode, _pval];
    if !( _pcode isEqualTo "" ) then {
        call compileFinal _var;
        [0,"Parameter %1 compiled: %2", _pname, _var] call SEN_fnc_log;
    };
} forEach paramsArray;

true
