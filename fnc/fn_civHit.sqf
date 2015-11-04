params ["_target", "_shooter", "_damage"];

if (local _target && {alive _target} && {side _target isEqualTo CIVILIAN} && {isPlayer _shooter} && {!(_target getvariable ["ACE_isUnconscious", false])} && {!(_target getVariable ["JK_isBomber", false])}) then {
    SEN_approvalCiv = SEN_approvalCiv - (30 + (random 30));
    publicVariable "SEN_approvalCiv";
    [2, format ["fn_civHit: Player %1 have shoot on %2 at Distance %3 and make %4 Damage.", name _shooter, name _target, _target distance _shooter, _damage]] call SEN_fnc_log;
};
