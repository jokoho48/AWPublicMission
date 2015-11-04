JK_fnc_applyDamage = {
    private "_damageVar";
    params ["_unit", "_selection", "_newDamage", "_typeOf"];
    _damageVar = _unit getvariable ["ace_medical_bodyPartStatus", [0,0,0,0,0,0]];
    if (local _unit) then {
        [_unit, _selection, (_damageVar select ([_selection] call ace_medical_fnc_selectionNameToNumber)) + _newDamage, _unit, _typeOf] call ace_medical_fnc_handleDamage;
    } else {
        [[_unit, _selection, (_damageVar select ([_selection] call ace_medical_fnc_selectionNameToNumber)) + _newDamage, _unit, _typeOf], "ace_medical_fnc_handleDamage", _unit, false, true] call BIS_fnc_MP;
    };
};

EXPLOSIVESEQUENCE_SMALL = {
    [_this, ["M_Titan_AP","M_Titan_AP"], true, true, "small"] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_MEDIUM = {
    [_this, ["HelicopterExploBig","M_PG_AT","M_Titan_AT","M_Titan_AP"], true, true, "medium"] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_LARGE = {
    [_this, ["Bo_GBU12_LGB_MI10", "HelicopterExploSmall"], true, true, "large"] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_DISARM = {
    [_this, ["Bo_GBU12_LGB_MI10","Bo_GBU12_LGB_MI10"], false, true] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_SECONDARY = {
    [_this, ["R_80mm_HE","R_80mm_HE"], false, false] spawn PRIMARY_EXPLOSION;
};

PRIMARY_EXPLOSION = {
    private ["_iedArray", "_iedPosition", "_explosiveSequence", "_createSecondary", "_createSmoke", "_size", "_numberOfFragments", "_sleepTime", "_iedItem"];
    _iedArray = [];
    try {
        _iedArray = (_this select 0) call GET_IED_ARRAY;
        if(typeName _iedArray != "ARRAY") exitWith {if(SEN_debug) then { hint "attempt to blow up already disarmed ied caught";};};

        _iedPosition = getpos (_iedArray select 0);
        if (!JK_isExploded) then {
            playSound3D ["z\ace\addons\explosives\Data\Audio\Cellphone_Ring.wss",objNull, false, getPosASL (_iedArray select 0),3.16228,1,75];
            sleep 2;
        };
        JK_isExploded = false;
        publicVariable "JK_isExploded";

        terminate (_iedArray select 5);    //need to stop these so we don't get double explosions
        deleteVehicle (_iedArray select 1);  //need to stop these so we don't get double explosions
        (_iedArray select 0) removeAllEventHandlers "HitPart";
        (_this select 0 select 0) call INCREMENT_EXPLOSION_COUNTER;
        _explosiveSequence = (_this select 1);
        _createSecondary = (_this select 2);
        _createSmoke = [_this, 3, true] call BIS_fnc_param;
        _size = [_this, 4, "large"] call BIS_fnc_param;
        _numberOfFragments = 150;

        [[_iedPosition] , "IED_SCREEN_EFFECTS", true, false] spawn BIS_fnc_MP;

        lastIedExplosion = _iedPosition;
        publicVariable "lastIedExplosion";

        0 = [_iedPosition, _explosiveSequence] spawn {
            private ["_explosive", "_xCoord", "_yCoord", "_ied"];
            params ["_iedPosition", "_explosiveSequence"];

            for "_i" from 0 to (count _explosiveSequence) -1 do {
                [[_iedPosition] , "IED_ROCKS", true, false] spawn BIS_fnc_MP;
                _explosive = (_explosiveSequence select _i);
                _xCoord = (random 4)-2;
                _yCoord = (random 4)-2;
                _ied = _explosive createVehicle _iedPosition;
                hideObjectGlobal _ied;
                _ied setPos [(_iedPosition select 0) + _xCoord, (_iedPosition select 1) + _yCoord, 2];
                if(((position player) distanceSqr getPos _ied) < 40000) then {  //less than 200 meters away
                    addCamShake [1 + random 5, 1 + random 3, 5 + random 15];
                };
                sleep .01;
            };
        };

        if(_createSmoke) then {
            if(_size == "large") then {
                [[_iedPosition] , "IED_SMOKE_LARGE", true, false] spawn BIS_fnc_MP;
                _numberOfFragments = 300;
            } else {
                if(_size == "small") then {
                    [[_iedPosition] , "IED_SMOKE_SMALL", true, false] spawn BIS_fnc_MP;
                    _numberOfFragments = 100;
                } else {
                    if(_size == "medium") then {
                        [[_iedPosition] , "IED_SMOKE_MEDIUM", true, false] spawn BIS_fnc_MP;
                        _numberOfFragments = 200;
                    };
                };
            };
        };

        //fragmentation
        [_iedPosition, _numberOfFragments] spawn CREATE_FRAGMENTS;
        _iedItem = (_iedArray select 0);
        sleep .5;
        (_this select 0) call REMOVE_IED_ARRAY;

        if(_createSecondary) then {
            if(random 100 < secondaryChance) then {
                _sleepTime = 10;
                if(SEN_debug) then {
                    hint format["Creating Secondary Explosive"];
                };
                sleep _sleepTime;
                [[_iedPosition, _iedArray select 2, _this select 0 select 0], "CREATE_SECONDARY_IED", false, false] call BIS_fnc_MP;
            };
        };
        {
            private "_interSect";
            _interSect = lineIntersectsSurfaces [_iedPosition, getPos _x, _x, _iedItem, true, -1, "FIRE", "VIEW"];
            if (SEN_debug) then {
                [_iedPosition, getPos _x, [1,1,0,1]] call ace_common_fnc_addLineToDebugDraw;
            };
            if !(_interSect isEqualTo []) then {
                if (isPlayer _x && _x == vehicle _x) then {
                    private ["_distance" ,"_distanceDamage", "_damageVar"];
                    _distance = (_iedPosition distance _x) min 25;
                    _distanceDamage = _distance - 25;
                    _distanceDamage = _distanceDamage / 6;
                    _distanceDamage = _distanceDamage - _distanceDamage - _distanceDamage;
                    [_x, "body", _distanceDamage, "shell"] call JK_fnc_applyDamage;
                    [_x, "head", _distanceDamage, "shell"] call JK_fnc_applyDamage;
                    [_x, "hand_l", _distanceDamage, "shell"] call JK_fnc_applyDamage;
                    [_x, "hand_r", _distanceDamage, "shell"] call JK_fnc_applyDamage;
                    [_x, "leg_l", _distanceDamage, "shell"] call JK_fnc_applyDamage;
                    [_x, "leg_r", _distanceDamage, "shell"] call JK_fnc_applyDamage;
                };
            };
            nil
        } count (_iedPosition nearEntities ["Man", 25]);
        sleep 5;
        publicVariable "iedDictionary";
    } catch {
        if (true) exitWith {hint "not allowed to blow this ied up";};
    };
};

CREATE_FRAGMENTS = {
    private ["_numberOfFragments"];
    params ["_pos", "_numberOfFragments"];
    _numberOfFragments = _this select 1;
    for "_i" from 0 to _numberOfFragments - 1 do{
        private ["_bullet", "_angle", "_speed"];
        _pos set[2, 0.1 + random 2];
        _bullet = "B_408_Ball" createVehicle _pos;
        _angle = random 360;
        _speed = 450 + random 100;
        _bullet setVelocity [_speed * cos(_angle), _speed * sin(_angle), -1 * (random 4)];
    };
};



/*------ stops a tank
Bo_GBU12_LGB_MI10
Bo_GBU12_LGB
Bo_Mk82
------ stops a marshall
HelicopterExploSmall

------stops a hunter
M_Mo_82mm_AT_LG
HelicopterExploBig
M_Air_AA_MI02

------ low damage
M_Titan_AA_long
M_Zephyr
M_Air_AT
M_Titan_AA
M_Titan_AT
R_80mm_HE
M_PG_AT

------ white smoke glows bright at night
R_230mm_HE*/
