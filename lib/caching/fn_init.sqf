JK_maxInfDistance1 = 1500;
JK_maxInfDistance2 = 3000;
JK_LoopTime = 30;
JK_cachedDebug = true;
JK_usedDifferentGear = false;
//#define JK_usedDifferentGear

JK_cachedAllArray = [];

#include "fn_functions.sqf"

[] spawn {
    while {true} do {
        {
            if ((vehicle (leader _x)) isKindOf "Man") then {
                _distance = [_x, JK_maxInfDistance1, JK_maxInfDistance2] call JK_fnc_checkPlayerDistance;
                if (_distance != 0) then {
                    [_x] call JK_fnc_uncacheLeader;
                } else {
                    if (_distance == 1) then {
                        [_x] call JK_fnc_cacheLeader;
                    } else {
                        [_x] call JK_fnc_cacheAll;
                    };
                };
            };
        } count allGroups;
        {
            _distance = [_x, JK_maxInfDistance1, JK_maxInfDistance2] call JK_fnc_checkPlayerDistance;
            if (_distance != 0) then {
                [_x] call JK_fnc_uncacheAll;
            };
        } count JK_cachedAllArray;
        uiSleep JK_LoopTime;
    };
};
