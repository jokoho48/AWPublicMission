JK_badClassnamesOld = [];
[{
    private "_fnc_PFH";
    _fnc_PFH = {
        private "_entrys";
        _entrys = (entities "");
        if (_entrys isEqualTo JK_badClassnamesOld) exitWith {};
        {
            if ((isNil (format ["ace_interact_menu_Act_%1", typeOf _x])) || {isNil (format ["ace_interact_menu_SelfAct_%1", typeOf _x])}) then {
                if !(_x in JK_badClassnamesOld) then {
                    [_x] call SLX_XEH_EH_Init;
                    _x addEventHandler ["fired", {_this call SLX_XEH_EH_Fired}];
                    _x addEventHandler ["animChanged", {_this call SLX_XEH_EH_AnimChanged}];
                    _x addEventHandler ["animDone", {_this call SLX_XEH_EH_AnimDone}];
                    _x addEventHandler ["animStateChanged", {_this call SLX_XEH_EH_AnimStateChanged}];
                    _x addEventHandler ["containerClosed", {_this call SLX_XEH_EH_ContainerClosed}];
                    _x addEventHandler ["controlsShifted", {_this call SLX_XEH_EH_ControlsShifted}];
                    _x addEventHandler ["containerOpened", {_this call SLX_XEH_EH_ContainerOpened}];
                    _x addEventHandler ["dammaged", {_this call SLX_XEH_EH_Dammaged}];
                    _x addEventHandler ["engine", {_this call SLX_XEH_EH_Engine}];
                    _x addEventHandler ["epeContact", {_this call SLX_XEH_EH_EpeContact}];
                    _x addEventHandler ["epeContactEnd", {_this call SLX_XEH_EH_EpeContactEnd}];
                    _x addEventHandler ["epeContactStart", {_this call SLX_XEH_EH_EpeContactStart}];
                    _x addEventHandler ["explosion", {_this call SLX_XEH_EH_Explosion}];
                    _x addEventHandler ["firedNear", {_this call SLX_XEH_EH_FiredNear}];
                    _x addEventHandler ["fuel", {_this call SLX_XEH_EH_Fuel}];
                    _x addEventHandler ["gear", {_this call SLX_XEH_EH_Gear}];
                    _x addEventHandler ["getIn", {_this call SLX_XEH_EH_GetIn}];
                    _x addEventHandler ["getOut", {_this call SLX_XEH_EH_GetOut}];
                    _x addEventHandler ["handleHeal", {_this call SLX_XEH_EH_HandleHeal}];
                    _x addEventHandler ["hit", {_this call SLX_XEH_EH_Hit}];
                    _x addEventHandler ["hitPart", {_this call SLX_XEH_EH_HitPart}];
                    _x addEventHandler ["incomingMissile", {_this call SLX_XEH_EH_IncomingMissile}];
                    _x addEventHandler ["inventoryClosed", {_this call SLX_XEH_EH_InventoryClosed}];
                    _x addEventHandler ["inventoryOpened", {_this call SLX_XEH_EH_InventoryOpened}];
                    _x addEventHandler ["killed", {_this call SLX_XEH_EH_Killed}];
                    _x addEventHandler ["landedTouchDown", {_this call SLX_XEH_EH_LandedTouchDown}];
                    _x addEventHandler ["landedStopped", {_this call SLX_XEH_EH_LandedStopped}];
                    _x addEventHandler ["local", {_this call SLX_XEH_EH_Local}];
                    _x addEventHandler ["respawn", {_this call SLX_XEH_EH_Respawn}];
                    _x addEventHandler ["put", {_this call SLX_XEH_EH_Put}];
                    _x addEventHandler ["take", {_this call SLX_XEH_EH_Take}];
                    _x addEventHandler ["seatSwitched", {_this call SLX_XEH_EH_SeatSwitched}];
                    _x addEventHandler ["soundPlayed", {_this call SLX_XEH_EH_SoundPlayed}];
                    _x addEventHandler ["weaponAssembled", {_this call SLX_XEH_EH_WeaponAssembled}];
                    _x addEventHandler ["weaponDisAssembled", {_this call SLX_XEH_EH_WeaponDisassembled}];
                    JK_badClassnamesOld pushBack _x;
                };
            };
            nil
        } count (_entrys - JK_badClassnamesOld);
    };
    call _fnc_PFH;
    [_fnc_PFH, 30, []] call CBA_fnc_addPerFrameHandler;
}, [], 4] call ace_common_fnc_waitAndExecute;
