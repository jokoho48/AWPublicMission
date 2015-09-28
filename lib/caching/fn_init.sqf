JK_maxInfDistance1 = 1500;
JK_maxInfDistance2 = 3000;
JK_LoopTime = 30;
JK_usedDifferentGear = false;

//#define JK_usedDifferentGear
//#define JK_cachedDebug

JK_cachedAllArray = [];

#include "fn_functions.sqf"

[] spawn {
    while {true} do {
        {
            if !(isPlayer (leader _x)) then {
                if ((vehicle (leader _x)) isKindOf "Man" && {!isNil {(leader _x) getVariable "JK_CachedUnits"}}) then {
                    _distance = [_x, JK_maxInfDistance1, JK_maxInfDistance2] spawn JK_fnc_checkPlayerDistance;
                    if (_distance != 0) then {
                        [_x] spawn JK_fnc_uncacheLeader;
                    } else {
                        if (_distance == 1) then {
                            [_x] spawn JK_fnc_cacheLeader;
                        } else {
                            [_x] spawn JK_fnc_cacheAll;
                        };
                    };
                };
                sleep 0.001;
            };
        } count allGroups;
        {
            _distance = [_x, JK_maxInfDistance1, JK_maxInfDistance2] spawn JK_fnc_checkPlayerDistance;
            if (_distance != 0) then {
                [_x] spawn JK_fnc_uncacheAll;
            };
            sleep 0.001;
        } count JK_cachedAllArray;
        uiSleep JK_LoopTime;
    };
};
