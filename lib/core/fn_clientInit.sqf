fn_STMG_AssignClientIDOnServer =
{
    _unitName = _this select 0;
    {
        if (name _x == _unitName) then {_x setVariable ["stmg_owner_id",owner _x,true];};
        nil
    } count playableUnits;
};

if (isDedicated) exitWith {}; // Just in case

fn_STMG_MapGestures_InitVariables = {
    if (isNil "STMG_MapGestures_Active") then {STMG_MapGestures_Active = true};
    if (isNil "STMG_MapGestures_MaxRange") then {STMG_MapGestures_MaxRange = 7};
    if (isNil "STMG_MapGestures_SleepTimeUpdate") then {STMG_MapGestures_SleepTimeUpdate = 0.03};
    if (isNil "STMG_MapGestures_EnableTransmit") then {STMG_MapGestures_EnableTransmit = false};

    if (isNil "STMG_MapGestures_GroupColors_Red") then {STMG_MapGestures_GroupColors_Red = ["ASL", "AV", "A1", "A2", "A3", "A4","DSL", "DV", "D1", "D2", "D3", "D4","GSL", "GV", "G1", "G2", "G3", "G4"]};
    if (isNil "STMG_MapGestures_GroupColors_Green") then {STMG_MapGestures_GroupColors_Green = ["CSL", "CV", "C1", "C2", "C3", "C4","FSL", "FV", "F1", "F2", "F3", "F4","ISL", "IV", "I1", "I2", "I3", "I4"]};
    if (isNil "STMG_MapGestures_GroupColors_Blue") then {STMG_MapGestures_GroupColors_Blue = ["BSL", "BV", "B1", "B2", "B3", "B4","ESL", "EV", "E1", "E2", "E3", "E4","HSL", "HV", "H1", "H2", "H3", "H4"]};
    if (isNil "STMG_MapGestures_GroupColors_Yellow") then {STMG_MapGestures_GroupColors_Yellow = ["CoyHQ", "CoyV","PltHQ", "PV","PltHQ2", "P2V","PltHQ3", "P3V"]};
    if (isNil "STMG_MapGestures_GroupColors_DarkYellow") then{STMG_MapGestures_GroupColors_DarkYellow = ["WSL", "WV","MMG1", "MMG2", "MMG3","MAT1", "MAT2", "MAT3","HMG1", "HMG2", "HMG3","HAT1", "HAT2", "HAT3"]};
    if (isNil "STMG_temp_debug") then {STMG_temp_debug = false};

    player setVariable ["STMG_MapGestures_Transmit",false,true];
};

fn_STMG_MapGesture_SanitizeNameToAlphabet = {
    _name = _this select 0;
    _alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
    _nameSanitized = "";

    for "_i" from 0 to ((count _name)-1) do {
        _selChar = toString[((toArray(_name)) select _i)];
        if (_selChar in _alphabet) then {_nameSanitized = _nameSanitized + _selChar};
    };

    _nameSanitized
};

fn_STMG_MapGestures_MapDraw = {
    if !(!visibleMap || !STMG_MapGestures_Active) then {
        _nearDudes = (position player) nearEntities [["CAManBase"], STMG_MapGestures_MaxRange];
        _nearDudes = _nearDudes - [player];
        _nearDudes = _nearDudes + (crew vehicle player);

        {
            _nameSane = [name _x] call fn_STMG_MapGesture_SanitizeNameToAlphabet;

            if !(isNil format["STMG_%1_DrawPos",_nameSane]) then {
                _pos = call compile format["STMG_%1_DrawPos",_nameSane];

                if (alive _x && (_pos distance [0,0,0] > 50) && (_x getVariable "STMG_MapGestures_Transmit")) then {
                    _grpname = groupID (group _x);

                    _alpha = .7;
                    if (_x == leader (group _x)) then {_alpha = .95};

                    _color = [1,.88,0,_alpha];

                    _pastelVal = .5;

                    _red = [1,_pastelVal,_pastelVal,_alpha];
                    _green = [_pastelVal,1,_pastelVal,_alpha];
                    _blue = [_pastelVal,_pastelVal,1,_alpha];
                    _yellow = [1,.78,0,_alpha];
                    _dark_yellow = [1,.38,0,_alpha];

                    if (_grpname in STMG_MapGestures_GroupColors_Yellow) then {_color = _yellow};
                    if (_grpname in STMG_MapGestures_GroupColors_Red) then {_color = _red};
                    if (_grpname in STMG_MapGestures_GroupColors_Blue) then {_color = _blue};
                    if (_grpname in STMG_MapGestures_GroupColors_Green) then {_color = _green};
                    if (_grpname in STMG_MapGestures_GroupColors_DarkYellow) then {_color = _dark_yellow};

                    (_this select 0) drawIcon ["\a3\ui_f\data\gui\cfg\Hints\icon_text\group_1_ca.paa", [_color select 0, _color select 1, _color select 2, _color select 3], _pos, 55, 55, 0, "", 1, 0.030,"PuristaBold","left"];
                    (_this select 0) drawIcon ["#(argb,8,8,3)color(0,0,0,0)", [.2,.2,.2,.3], _pos, 20, 20, 0, _nameSane, 0, 0.030,"PuristaBold","left"];
                };
            };
            nil
        } count _nearDudes;
    };
};

// Should only run this once, due to the spawned waitUntil. If we re-init it, we need to do STMG_MapGestures_Active = false first
fn_STMG_MapGestures_Init_Receiver = {
    fn_STMG_MapGestures_ClientMonitor = {
        waitUntil {
            waitUntil {!visibleMap || !STMG_MapGestures_Active};

            if (STMG_MapGestures_Active) then { {
                    if (isPlayer _x) then {
                        _nameSane = [name _x] call fn_STMG_MapGesture_SanitizeNameToAlphabet;
                        call compile format["STMG_%1_DrawPos = [1,1,1];",_nameSane];
                    };
                    nil
                } count allUnits;
            };
            waitUntil {!STMG_MapGestures_Active || visibleMap};

            // If we close the map while the mouse button is held down, this will clear things out.
            player setVariable ["STMG_MapGestures_Transmit",false,true];
            STMG_MapGestures_EnableTransmit = false;

            !STMG_MapGestures_Active
        };
    };

    if (!isNil "STMG_MapGestures_Index") then {
        (findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["Draw",STMG_MapGestures_Index];
        STMG_MapGestures_Index = nil;
        STMG_MapGestures_Active = false;
    };

    STMG_MapGestures_Index = findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {call fn_STMG_MapGestures_MapDraw;}];

    [] spawn fn_STMG_MapGestures_ClientMonitor;
};

// Can update, reinit this. It will remove existing handlers, then add new ones.
fn_STMG_MapGestures_Init_Sender = {
    // MouseMoving EH.
    if (!isNil "STMG_MapGestures_MouseMoveHandler_Index") then {
        (findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["MouseMoving",STMG_MapGestures_MouseMoveHandler_Index];
        STMG_MapGestures_MouseMoveHandler_Index = nil;
    };

    STMG_MapGestures_MouseMoveHandler_Index = findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["MouseMoving", {
        _control = _this select 0;
        _posX = _this select 1;
        _posY = _this select 2;

        if (STMG_MapGestures_EnableTransmit) then {
             if !(player getVariable "STMG_MapGestures_Transmit") then {
                 player setVariable ["STMG_MapGestures_Transmit",true,true];
             };

            _nameSane =  [name player] call fn_STMG_MapGesture_SanitizeNameToAlphabet;
            call compile format["STMG_%1_DrawPos = %2",_nameSane,(findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld [_posX,_posY]];
        };
    }];


    // MouseDown EH
    if (!isNil "STMG_MapGestures_MouseDown_Index") then {
        (findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["MouseButtonDown",STMG_MapGestures_MouseDown_Index];
        STMG_MapGestures_MouseDown_Index = nil;
    };

    STMG_MapGestures_MouseDown_Index = findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["MouseButtonDown", {
        if (!STMG_MapGestures_Active) exitWith {};
        _button = _this select 1;

        if (_button == 0) then {
            call fn_STMG_MapGestures_InitTransmit;
        };
    }];

    // MouseUp EH
    if (!isNil "STMG_MapGestures_MouseUp_Index") then {
        (findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["MouseButtonUp",STMG_MapGestures_MouseUp_Index];
        STMG_MapGestures_MouseUp_Index = nil;
    };
    STMG_MapGestures_MouseUp_Index = findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["MouseButtonUp",{
        if (!STMG_MapGestures_Active) exitWith {};
        call fn_STMG_MapGestures_EndTransmit;
    }];

    // The functions for what happens when initializing, transmitting, and ending a transmission
    fn_STMG_MapGestures_InitTransmit = {
        if (!STMG_MapGestures_Active) exitWith {};
        STMG_MapGestures_EnableTransmit = true;
        [] spawn fn_STMG_MapGestures_WhileTransmit;
    };

    fn_STMG_MapGestures_EndTransmit = {
        if (!STMG_MapGestures_Active) exitWith {};
        _button = _this select 1;

        if (_button == 0) then {
            player setVariable ["STMG_MapGestures_Transmit",false,true];
            STMG_MapGestures_EnableTransmit = false;
        };
    };

    fn_STMG_MapGestures_WhileTransmit = {
        if (!STMG_MapGestures_EnableTransmit) exitWith {};
        waitUntil {
            _nearDudes = (position player) nearEntities [["CAMAnBase"], STMG_MapGestures_MaxRange];
            _nearDudes = _nearDudes - [player];
            _nearDudes = _nearDudes + (crew vehicle player);

            if (STMG_temp_debug) then {systemChat format["Near: %1",_nearDudes];};

            {
                _ownerID = -1;

                if (isNil {_x getVariable "STMG_owner_id"}) then {
                    [0, {[_this] call fn_STMG_AssignClientIDOnServer},(name _x)] call cba_fnc_GlobalExecute;
                    waitUntil {
                        !isNil {_x getVariable "STMG_owner_id"}
                    };
                    _ownerID = _x getVariable "STMG_owner_id";
                } else {
                    _ownerID = _x getVariable "STMG_owner_id";
                };

                if (_ownerID != player getVariable "STMG_owner_id") then {
                    _nameSane = [name player] call fn_STMG_MapGesture_SanitizeNameToAlphabet;
                    _ownerID publicVariableClient format["STMG_%1_DrawPos",_nameSane];
                };
                nil
            } count _nearDudes;
            sleep STMG_MapGestures_SleepTimeUpdate;
            !STMG_MapGestures_EnableTransmit
        };
    };
};

[] spawn {
    waitUntil {!(isNull player)};
    waitUntil {player == player};
    waitUntil {time > 5};
    call fn_STMG_MapGestures_InitVariables;
    call fn_STMG_MapGestures_Init_Receiver;
    call fn_STMG_MapGestures_Init_Sender;
};
