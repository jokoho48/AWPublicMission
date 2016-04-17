// reset all Variables

{
    private _varName = _x;
    {
        _x setVariable [_varName, nil];
    } count [missionNamespace, uiNamespace, parsingNamespace];
    nil
} count [
    "JK_uniforms","JK_vests","JK_headgears","JK_backpacks",
    "JK_insignium","JK_useProfileGoggles","JK_goggles",
    "JK_primaryweapon","JK_itemsPrimaryweapon","JK_ARhandle",
    "JK_primaryweaponAmmo","JK_primaryweaponAmmoCount",
    "JK_primaryweaponTracers","JK_primaryweaponTracersCount",
    "JK_40mmHeGrenadesAmmo","JK_40mmSmokeGrenadesWhite",
    "JK_40mmSmokeGrenadesYellow","JK_40mmSmokeGrenadesOrange",
    "JK_40mmSmokeGrenadesRed","JK_40mmSmokeGrenadesPurple",
    "JK_40mmSmokeGrenadesBlue","JK_40mmSmokeGrenadesGreen",
    "JK_40mmFlareWhite","JK_40mmFlareYellow","JK_40mmFlareRed",
    "JK_40mmFlareGreen","JK_40mmFlareIR","JK_handgun","JK_itemsHandgun",
    "JK_handgunAmmo","JK_launcher","JK_launcherHandle","JK_launcherItems",
    "JK_launcherAmmo","JK_binocular","JK_grenadeHE","JK_grenadeSmokeWhite",
    "JK_grenadeSmokeYellow","JK_grenadeSmokeOrange","JK_grenadeSmokeRed",
    "JK_grenadeSmokePurple","JK_grenadeSmokeBlue","JK_grenadeSmokeGreen",
    "JK_chemlightYellow","JK_chemlightRed","JK_chemlightGreen","JK_chemlightBlue",
    "JK_IRgrenade","JK_IVBagSaline250","JK_IVBagSaline500","JK_IVBagSaline1000",
    "JK_epinephrine","JK_morphine","JK_atropine","JK_fieldDressing",
    "JK_packingBandage","JK_elasticBandage","JK_quikclot","JK_tourniquet",
    "JK_earPlugs","JK_swapBarrel","JK_FirstAidKits","JK_MediKit",
    "JK_itemsUniform","JK_itemsVest","JK_itemsBackpack","JK_itemsLink",
    "JK_items","JK_medicClass","JK_spawnAllowed","JK_isEngineer","JK_isPilot","JK_VehClass"
];
