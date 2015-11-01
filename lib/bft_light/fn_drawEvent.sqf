private ["_map"];
disableSerialization;
if (SEN_debug) then {
    diag_log "DRAW";
};
_map = ((findDisplay 12) displayCtrl 51);
{
  _map drawIcon _x;
} forEach BG_BFT_Icons;
