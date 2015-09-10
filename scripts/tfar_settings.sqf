if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
   call compile preprocessFileLineNumbers "\task_force_radio\functions\common.sqf";

   tf_radio_channel_name = "LaufendeMission";
   tf_radio_channel_password = "armaworld";

   tf_no_auto_long_range_radio = true;
   tf_give_personal_radio_to_regular_soldier = false;
   TF_give_microdagr_to_soldier = false;
   tf_same_sw_frequencies_for_side = true;
   tf_same_lr_frequencies_for_side = true;
   tf_terrain_interception_coefficient = 7.0;

   //radios
   BLU_F_personal_tf_faction_radio = "tf_anprc152";
   BLU_G_F_personal_tf_faction_radio = "tf_anprc148jem";
   BLU_F_rifleman_tf_faction_radio = "tf_rf7800str";
   BLU_G_F_rifleman_tf_faction_radio = "tf_anprc154";

   IND_F_personal_tf_faction_radio = "tf_anprc148jem";
   IND_F_rifleman_tf_faction_radio = "tf_anprc154";

   OPF_F_personal_tf_faction_radio = "tf_fadak";
   OPF_F_rifleman_tf_faction_radio = "tf_pnr1000a";

   //frequencies
   //blufor
   _settingsSwWest = false call TFAR_fnc_generateSwSettings;
   _settingsSwWest set [2, ["131.5","132","132.5","133","133.5","134","134.5","135"]];
   _settingsSwWest set [4, "_bluefor"];
   tf_freq_west = _settingsSwWest;
   _settingsLrWest = false call TFAR_fnc_generateLrSettings;
   _settingsLrWest set [2, ["42","42.1","42.2","42.3","42.4","42.5","42.6","42.7","42.8"]];
   _settingsLrWest set [4, "_bluefor"];
   tf_freq_west_lr = _settingsLrWest;

   _settingsSwEast = false call TFAR_fnc_generateSwSettings;
   _settingsSwEast set [2, ["221.5","222","222.5","223","223.5","224","224.5","225"]];
   _settingsSwEast set [4, "_opfor"];
   tf_freq_east = _settingsSwEast;
   _settingsLrEast = false call TFAR_fnc_generateLrSettings;
   _settingsLrEast set [2, ["32","32.1","32.2","32.3","32.4","32.5","32.6","32.7","32.8"]];
   _settingsLrEast set [4, "_opfor"];
   tf_freq_east_lr = _settingsLrEast;

   _settingsSwGuer = false call TFAR_fnc_generateSwSettings;
   _settingsSwGuer set [2, ["341.5","342","342.5","343","343.5","344","344.5","345"]];
   if ((independent getFriend west)>0.6) then {_settingsSWGuer set [4, "_bluefor"];} else {
      if ((independent getFriend east)>0.6) then {_settingsSWGuer set [4, "_opfor"];} else {
         _settingsSWGuer set [4, "_indfor"];
      };
   };
   tf_freq_guer = _settingsSwGuer;
   _settingsLrGuer = false call TFAR_fnc_generateLrSettings;
   _settingsLrGuer set [2, ["52","52.1","52.2","52.3","52.4","52.5","52.6","52.7","52.8"]];
   if ((independent getFriend west)>0.6) then {_settingsLrGuer set [4, "_bluefor"];} else {
      if ((independent getFriend east)>0.6) then {_settingsLrGuer set [4, "_opfor"];} else {
         _settingsLrGuer set [4, "_indfor"];
      };
   };
   tf_freq_guer_lr = _settingsLrGuer;

};

if ( isClass (configFile >> "CfgPatches" >> "acre_main") ) then {

   //Initialize ACRE radios
   [true] call acre_api_fnc_setRevealToAI;
   [false] call acre_api_fnc_setFullDuplex;
   [true] call acre_api_fnc_setInterference;
   [0.6] call acre_api_fnc_setLossModelScale;
   //babel:
   [[west, "English"],[east, "Russian"],[independent, "English", "Russian"],[civilian, "English", "Russian"]] call acre_api_fnc_setupMission;
   ["en", "English"] call acre_api_fnc_babelAddLanguageType;
   ["ru", "Russian"] call acre_api_fnc_babelAddLanguageType;

   if !(isDedicated || !hasInterface) then {
      switch (side (group player) ) do {
         case west: {
            ["en"] call acre_api_fnc_babelSetSpokenLanguages;
         };
         case civilian: {
            ["en","ru"] call acre_api_fnc_babelSetSpokenLanguages;
         };
         case east: {
            ["ru"] call acre_api_fnc_babelSetSpokenLanguages;
         };
         case independent: {
            ["en","ru"] call acre_api_fnc_babelSetSpokenLanguages;
         };
      };
   };
};
