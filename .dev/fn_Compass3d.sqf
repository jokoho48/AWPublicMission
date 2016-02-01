JK_3DCompass_enabled = false;
JK_3DCompass_oldCenter = [0,0,0];
JK_DIFF = 8;
JK_3DCompass_fnc_compass = {
    _ins = lineIntersectsSurfaces [
        AGLToASL positionCameraToWorld [0,0,0],
        AGLToASL positionCameraToWorld [0,0,1000],
        player,
        objNull,
        true,
        1,
        "GEOM",
        "NONE"
    ];
    _center = if (_ins isEqualTo []) then {
        positionCameraToWorld [0,0,4]
    } else {
        [((_ins select 0) select 0) select 0, ((_ins select 0) select 0) select 1, 0]
    };

    {
        _x params ["_letter", "_color", "_offset1", "_offset2"];

        drawIcon3D [
            "",
            _color,
            _center vectorAdd _offset1,
            0,
            0,
            0,
            _letter,
            2,
            0.05,
            "PuristaMedium"
        ];

        drawIcon3D [
            "",
            _color,
            _center vectorAdd _offset2,
            0,
            0,
            0,
            ".",
            2,
            0.05,
            "PuristaMedium"
        ];
    } count [
        ["N",[1,1,1,1],[0,1,0],[0,0.5,0]],
        ["S",[1,1,1,0.7],[0,-1,0],[0,-0.5,0]],
        ["E",[1,1,1,0.7],[1,0,0],[0.5,0,0]],
        ["W",[1,1,1,0.7],[-1,0,0],[-0.5,0,0]]
    ];
};

JK_3DCompass_fnc_addPFH = {
    if (isNil "JK_3DCompass_PFH") then {
        JK_3DCompass_PFH = [JK_3DCompass_fnc_compass, 0, []] call CBA_fnc_addPerFrameHandler;
    };
    JK_3DCompass_enabled = true;
};

JK_3DCompass_fnc_removePFH = {
    [JK_3DCompass_PFH] call CBA_fnc_removePerFrameHandler;
    JK_3DCompass_PFH = nil;
    JK_3DCompass_enabled = false;
};

["playerVehicleChanged", {
    params ["_player", "_vehicle"];
    if (_vehicle isKindof "Air" && (headGear _player) in ["H_CrewHelmetHeli_B"] && _player in [gunner _vehicle, driver _vehicle, commander _vehicle]) then {
        JK_3DCompass_Action1 = _player addAction ["Enable 3D Compass", JK_3DCompass_fnc_addPFH, nil, 1.5, true, false, "", "!JK_3DCompass_enabled"];
        JK_3DCompass_Action2 = _player addAction ["Disable 3D Compass", JK_3DCompass_fnc_removePFH, nil, 1.5, true, false, "", "JK_3DCompass_enabled"];
    } else {
        if (!isNil "JK_3DCompass_PFH") then {
            call JK_3DCompass_fnc_removePFH;
        };
        if (!isNil "JK_3DCompass_Action1") then {
            _player removeAction JK_3DCompass_Action1;
        };
        if (!isNil "JK_3DCompass_Action2") then {
            _player removeAction JK_3DCompass_Action2;
        };
    };
}] call ace_common_fnc_addEventhandler;
