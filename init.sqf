/*
@filename: init.sqf
Author:

    Quiksilver

Last modified:

    12/05/2014

Description:

    Things that may run on both server and client.
    Deprecated initialization file, still using until the below is correctly partitioned between server and client.
______________________________________________________*/


//call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";        // revive
DAC_Basic_Value = 0;
[] spawn compile preprocessFileLineNumbers "DAC\DAC_Config_Creator.sqf";

[] execVM "scripts\zlt_fieldrepair.sqf";    //Vehicle Repair Script


//-------------------------------------------------- Headless Client
