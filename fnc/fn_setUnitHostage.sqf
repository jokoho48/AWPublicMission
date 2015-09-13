/*
Author: SENSEI

Last modified: 8/15/2015

Description: set unit as hostage

        returns boolean
__________________________________________________________________*/
private "_anim";
params ["_unit"];

_anim = "Acts_AidlPsitMstpSsurWnonDnon02";
_unit setbehaviour "CARELESS";
_unit switchMove _anim;
_unit disableAI "ANIM";

true
