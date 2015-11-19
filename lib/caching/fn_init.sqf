if (!isServer) exitWith {};
JK_aiCacheDist = 2000;
JK_aiUnCacheDist = 1500;
JK_debug = true;
JK_cachedGroups = [];
JK_currentIndex = 1;
JK_maxIndex = 0;

#include "functions.sqf"

JK_fnc_registerGroupsPFH = {
    JK_maxIndex = ({
        private ["_disable", "_leader", "_return"];
        _return = false;
        _leader = leader _x;
        if (!isPlayer _leader && {!(_x getVariable ["JK_noCache", false])} && {!(_x in JK_cachedGroups)} && {(vehicle _leader == _leader)}) then {
            JK_cachedGroups pushBack _x;
            _return = true;
            _x setVariable ["JK_Leader", _leader];
            //_x setVariable ["JK_isCached", false];
        };
        _return
    } count allGroups) + JK_maxIndex;
};

JK_fnc_cachingLoop = {
    private "_group";
    if (JK_cachedGroups isEqualTo []) exitWith {};
    _group = JK_cachedGroups select (JK_currentIndex);
    _leader = leader _group;
    JK_currentIndex = (JK_currentIndex + 1) mod (JK_maxIndex - 1);

    // Delete Empty || groups that are Dead || that are not allow to Cache
    if (isNull _group || {_group getVariable ["JK_noCache", false]} || {({alive _x} count units _group isEqualTo 0)}) exitWith {
        if (JK_debug) then {
            hint format ["Empty Group %1", _group];
            diag_log format ["Empty Group %1", _group];
        };
        call JK_fnc_unCache;
        JK_cachedGroups deleteAt JK_currentIndex;
        JK_maxIndex = JK_maxIndex - 1;
        JK_currentIndex = (JK_currentIndex - 1) mod (JK_maxIndex - 1);
    };

    // Resync Team Leader
    if (!(alive (_group getVariable ["JK_Leader", objNull])) && {!(simulationEnabled (leader _group))}) exitWith {
        if (JK_debug) then {
            hint format ["Dead Leader in Group %1", _group];
            diag_log format ["Dead Leader in Group %1", _group];
        };
        call JK_fnc_unCache;
        _leader = (leader _group);
        _group setVariable ["JK_Leader", _leader];
        call JK_fnc_cache;
    };

    // UnCache Group
    if ((_group getVariable ["JK_isCached", true]) && {call JK_fnc_uncacheEvent}) exitWith {
        if (JK_debug) then {
            hint format ["unCache Group %1", _group];
            diag_log format ["unCache Group %1", _group];
        };
        call JK_fnc_unCache;
        call JK_fnc_setPosFull;
        _group setVariable ["JK_isCached", false];
    };

    // CacheGroup
    if (!(_group getVariable ["JK_isCached", false]) && {call JK_fnc_cacheEvent}) exitWith {
        if (JK_debug) then {
            hint format ["Cache Group %1", _group];
            diag_log format ["Cache Group %1", _group];
        };
        call JK_fnc_cache;
        _group setVariable ["JK_isCached", true];
    };

};

call JK_fnc_registerGroupsPFH;
[JK_fnc_registerGroupsPFH, 120, []] call CBA_fnc_addPerFrameHandler;
[JK_fnc_cachingLoop, 0, []] call CBA_fnc_addPerFrameHandler;
