//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 2.1 - 2009    //
//--------------------------//
//    DAC_Config_Units      //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

private ["_TypNumber","_TempArray","_Unit_Pool_S","_Unit_Pool_V","_Unit_Pool_T","_Unit_Pool_A"];
_TypNumber = _this select 0;_TempArray = [];

switch (_TypNumber) do
{
//-------------------------------------------------------------------------------------------------
// REDFOR (A3)
  case 0:
  {
    _Unit_Pool_S = ["O_crew_F","O_Helipilot_F","O_Soldier_SL_F","O_soldier_AR_F","O_soldier_AR_F","O_soldier_exp_F","O_soldier_GL_F","O_soldier_GL_F","O_soldier_M_F","O_medic_F","O_soldier_AA_F","O_soldier_repair_F","O_Soldier_F","O_Soldier_F","O_soldier_LAT_F","O_soldier_LAT_F","O_soldier_lite_F","O_soldier_TL_F","O_soldier_TL_F"];
    _Unit_Pool_V = ["O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","B_G_Offroad_01_armed_F","O_APC_Wheeled_02_rcws_F","I_APC_Wheeled_03_cannon_F"];
    _Unit_Pool_T = ["I_APC_Wheeled_03_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MBT_02_cannon_F","O_APC_Tracked_02_AA_F"];
	_Unit_Pool_A = ["O_Heli_Attack_02_F","O_Heli_Light_02_F","O_Heli_Light_02_armed_F"];
  };
//-------------------------------------------------------------------------------------------------
// BLUFOR (A3)
  case 1:
  {
    _Unit_Pool_S = ["B_crew_F","B_Helipilot_F","B_Soldier_SL_F","B_soldier_AR_F","B_soldier_AR_F","B_soldier_exp_F","B_soldier_GL_F","B_soldier_GL_F","B_soldier_AA_F","B_soldier_M_F","B_medic_F","B_soldier_repair_F","B_Soldier_F","B_Soldier_F","B_soldier_LAT_F","B_soldier_LAT_F","B_soldier_lite_F","B_soldier_TL_F","B_soldier_TL_F"];
    _Unit_Pool_V = ["B_MRAP_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F"];
    _Unit_Pool_T = ["B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_AA_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_MBT_01_arty_F","B_MBT_01_mlrs_F"];
    _Unit_Pool_A = ["B_Heli_Light_01_armed_F","B_Heli_Transport_01_camo_F","B_Heli_Light_01_F"];
  };
//-------------------------------------------------------------------------------------------------
// Independent (A3)
  case 2:
  {
    _Unit_Pool_S = ["I_crew_F","I_helipilot_F","I_officer_F","I_Soldier_AT_F","I_Soldier_AA_F","I_Soldier_M_F","I_Soldier_GL_F","I_Soldier_exp_F","I_engineer_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
    _Unit_Pool_V = ["I_Truck_02_covered_F","I_Truck_02_transport_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_MRAP_03_F"];
    _Unit_Pool_T = ["I_MBT_03_cannon_F","I_APC_tracked_03_cannon_F","I_APC_Wheeled_03_cannon_F"];
    _Unit_Pool_A = ["I_Heli_light_03_F"];
  };
//-------------------------------------------------------------------------------------------------
// Civilians (A3)
  case 3:
  {
    _Unit_Pool_S = ["C_man_1","C_man_1","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F"];
    _Unit_Pool_V = ["C_Van_01_box_F","C_Van_01_transport_F","C_Offroad_01_F","C_Hatchback_01_sport_F","C_Hatchback_01_F"];
    _Unit_Pool_T = ["C_Van_01_box_F","C_Van_01_transport_F","C_Offroad_01_F","C_Hatchback_01_sport_F","C_Hatchback_01_F"];
    _Unit_Pool_A = [];
  };
// OPFOR RHS Russians								@rhs_afrf3
// Russian Motor Rifle Troops (MSV)	Моторизо́ванные стрелко́вые войска, МСВ		rhs_faction_msv
  case 4:
  {
    _Unit_Pool_S = [
		"rhs_msv_driver_armored","rhs_msv_combatcrew","rhs_msv_sergeant",
		"rhs_msv_rifleman",
		"rhs_msv_grenadier",
		"rhs_msv_at",						//grenadier RPG
		"rhs_msv_strelok_rpg_assist",		//grenadier RPG assistant
		"rhs_msv_aa",
		"rhs_msv_efreitor",
		"rhs_msv_engineer",
		"rhs_msv_machinegunner",
		"rhs_msv_machinegunner_assistant",
		"rhs_msv_marksman",
		"rhs_msv_medic",
		"rhs_msv_LAT",						//rifleman RPG-26
		"rhs_msv_RShG2"						//rifleman RShG2
	];
    _Unit_Pool_V = [
		"rhs_tigr_msv",						//MRAP	
		"RHS_UAZ_MSV_01",
		"rhs_uaz_open_MSV_01",
		"RHS_BM21_MSV_01",					//rocket truck
		"rhs_gaz66_msv",
		"rhs_gaz66o_msv",
		"rhs_gaz66_r142_msv",				//radio truck
		"rhs_gaz66_ap2_msv",				//ambulance
		"RHS_Ural_MSV_01",
		"rhs_gaz66_repair_msv",
		"RHS_Ural_Fuel_MSV_01"
	];
    _Unit_Pool_T = [
		"rhs_btr60_msv",
		"rhs_btr70_msv",
		"rhs_btr80_msv",
		"rhs_btr80a_msv",
		"rhs_bmp1_msv",
		"rhs_bmp1d_msv",
		"rhs_bmp1k_msv",
		"rhs_bmp2_msv",
		"rhs_bmp2e_msv",
		"rhs_zsu234_aa",
		"rhs_prp3_msv",
		"rhs_t72ba_tv",
		"rhs_t80",
		"rhs_t72bc_tv",
		"rhs_t80u"
	];
    _Unit_Pool_A = [];
  };
//------------------------------------------------------------------------------------------------- 
// BLUFOR RHS Americans							??
// US Army (Woodland)							rhs_faction_usarmy_wd
  case 5:
  {
    _Unit_Pool_S = [
		"rhsusf_army_ocp_combatcrewman","rhsusf_army_ocp_helipilot","rhsusf_army_ocp_teamleader",
		"rhsusf_army_ocp_rifleman",
		"rhsusf_army_ocp_riflemanl",		//light
		"rhsusf_army_ocp_riflemanat",		//M136
		"rhsusf_army_ocp_grenadier",		//grenadier
		"rhsusf_army_ocp_marksman",
		"rhsusf_army_ocp_medic",
		"rhsusf_army_ocp_machinegunner",
		"rhsusf_army_ocp_machinegunnera",	//MG assistant
		"rhsusf_army_ocp_engineer",			
		"rhsusf_army_ocp_autorifleman",
		"rhsusf_army_ocp_aa",				//Stinger
		"rhsusf_army_ocp_javelin"			//Javelin
	];
    _Unit_Pool_V = [								
		"rhsusf_m998_w_2dr_fulltop",
		"rhsusf_m998_w_2dr_halftop",
		"rhsusf_m998_w_2dr",					
		"rhsusf_m998_w_4dr_fulltop",
		"rhsusf_m998_w_4dr_halftop",
		"rhsusf_m998_w_4dr",
		"rhsusf_m113_usarmy",
		"rhsusf_m1025_w"
	];
    _Unit_Pool_T = [
		"RHS_M6_wd",
		"rhsusf_m109_usarmy",
		"RHS_M2A2_BUSKI_WD",		
		"RHS_M2A3_BUSKI_wd",
		"RHS_M2A3_BUSKIII_wd",
		"RHS_M2A2_wd",
		"RHS_M2A3_wd",
		"rhsusf_m1a1aimwd_usarmy",					
		"rhsusf_m1a1aim_tuski_wd",
		"rhsusf_m1a2sep1wd_usarmy",
		"rhsusf_m1a2sep1tuskiwd_usarmy"
	];
    _Unit_Pool_A = [];
  };
//-------------------------------------------------------------------------------------------------
  Default
  {
    if(DAC_Basic_Value != 5) then
    {
      DAC_Basic_Value = 5;publicvariable "DAC_Basic_Value",
      hintc "Error: DAC_Config_Units > No valid config number";
    };
    if(true) exitwith {};
  };
};

if(count _this == 2) then
{
  _TempArray = _TempArray + [_Unit_Pool_S,_Unit_Pool_V,_Unit_Pool_T,_Unit_Pool_A];
}
else
{
  _TempArray = _Unit_Pool_V + _Unit_Pool_T + _Unit_Pool_A;
};
_TempArray