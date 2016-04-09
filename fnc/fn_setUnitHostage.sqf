/*
Author: SENSEI

Last modified: 8/15/2015

Description: set unit as hostage

        returns boolean
__________________________________________________________________*/
params ["_unit"];

_unit setbehaviour "CARELESS";
_unit switchMove "Acts_AidlPsitMstpSsurWnonDnon02";
_unit disableAI "ANIM";

true
