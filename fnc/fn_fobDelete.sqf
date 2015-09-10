/*
Author: SENSEI

Last modified: 8/14/2015

Description:  delete fob
__________________________________________________________________*/
if (!isServer) exitWith {};

if (getMarkerColor "sen_fob_mrk" isEqualTo "" || (missionNameSpace getVariable ["SEN_fobLock", false])) exitWith {};

SEN_curatorFOB removeCuratorCameraArea 0;
SEN_curatorFOB removeCuratorEditingArea 0;
SEN_flagFOB setposATL SEN_flagFOB_startPos;
SEN_curatorFOBUnitUID = "";
(owner (getAssignedCuratorUnit SEN_curatorFOB)) publicVariableClient "SEN_curatorFOBUnitUID";
[[SEN_curatorFOB],"SEN_fnc_fobRemoveEH",owner SEN_curatorFOB] call BIS_fnc_MP;
{SEN_objectCleanup pushBack _x} forEach (curatorEditableObjects SEN_curatorFOB);
//{if (!(isPlayer _x) && {side _x isEqualTo WEST}) then {SEN_objectCleanup pushBack _x}} forEach ((getmarkerpos "SEN_fob_mrk") nearEntities [["Man"], 100]);

deleteMarker "SEN_fob_mrk";
deleteMarker "SEN_fob_border_mrk";
deleteMarker "SEN_fob_recon_mrk";
unassignCurator SEN_curatorFOB;