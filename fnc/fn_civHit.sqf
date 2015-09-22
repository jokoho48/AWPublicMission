params ["_target", "_shooter"];

if (local _target && {alive _target} && {side _target isEqualTo CIVILIAN} && {isPlayer _shooter} && {!(_shooter getvariable ["ACE_isUnconscious", false])}) then {
    SEN_approvalCiv = SEN_approvalCiv - (15 + (random 15));
    publicVariable "SEN_approvalCiv";
};
