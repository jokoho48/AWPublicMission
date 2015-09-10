//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Config_Creator    //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

call (compile preprocessFileLineNumbers "DAC\Scripts\DAC_Preprocess.sqf");

scalar = "any";
DAC_Init_Camps = 0;

waituntil{time > 0.3};

if(isServer) then {if(local player) then {DAC_Code = 1} else {DAC_Code = 0}} else {if(isnull player) then {DAC_Code = 3} else {DAC_Code = 2}};

//===============|
// DAC_Settings	 |
//===============|=============================================================================================|

	if(isNil "DAC_STRPlayers") then {
        DAC_STRPlayers = [];
        {
            DAC_STRPlayers pushBack str _x;
            nil
        } count playableUnits;
        // ["uavOperator", "a1", "a2", "a3", "a4", "b1", "b2", "b3", "b4", "c1", "c2", "c3", "c4", "d1", "d2", "d3", "d4", "e1", "e2", "e3", "e4", "f1", "f2", "f3", "f4", "g1", "g2", "g3", "g4", "h1", "h2", "h3", "h4", "i1", "i2", "i3", "i4", "j1", "j2", "j3", "j4", "dustoff1", "dustoff2", "dustoff3", "eagle1", "eagle2", "rhino1", "rhino2", "rhino3"]
    };
	if(isNil "DAC_AI_Count_Level")	then {		DAC_AI_Count_Level  = [[2,4],[3,6],[4,8],[6,12],[1,0]];		};
	if(isNil "DAC_Dyn_Weather") 	then {		DAC_Dyn_Weather		= [0,0,0,[0, 0, 0],0];						};
	if(isNil "DAC_Reduce_Value") 	then {		DAC_Reduce_Value	= [1500,1750,0.3];							};
	if(isNil "DAC_AI_Spawn") 		then {		DAC_AI_Spawn		= [[10,5,5],[10,5,15],0,120,250,0];			};
	if(isNil "DAC_Delete_Value") 	then {		DAC_Delete_Value	= [[180,150],[180,150],6000];				};
	if(isNil "DAC_Del_PlayerBody") 	then {		DAC_Del_PlayerBody	= [0,0];										};
	if(isNil "DAC_Com_Values") 		then {		DAC_Com_Values		= [0,0,0,0];									};
	if(isNil "DAC_AI_AddOn") 		then {		DAC_AI_AddOn		= 1;											};
	if(isNil "DAC_AI_Level") 		then {		DAC_AI_Level		= 3;											};
	if(isNil "DAC_Res_Side") 		then {		DAC_Res_Side		= 0;											};
	if(isNil "DAC_Marker") 			then {		DAC_Marker			= 0;											};
	if(isNil "DAC_WP_Speed") 		then {		DAC_WP_Speed		= 0.01;										};
	if(isNil "DAC_Join_Action")		then {		DAC_Join_Action		= false;										};
	if(isNil "DAC_Fast_Init") 		then {		DAC_Fast_Init		= false;										};
	if(isNil "DAC_Player_Marker")	then {		DAC_Player_Marker	= false;										};
	if(isNil "DAC_Direct_Start")	then {		DAC_Direct_Start	= false;										};
	if(isNil "DAC_Activate_Sound")	then {		DAC_Activate_Sound	= false;										};
	if(isNil "DAC_Auto_UnitCount")	then {		DAC_Auto_UnitCount	= [8,10];									};
	if(isNil "DAC_Player_Support")	then {		DAC_Player_Support	= [10,[4,2000,3,1000]];						};
	if(isNil "DAC_SaveDistance")	then {		DAC_SaveDistance	= [500,["DAC_Save_Pos"]];					};
	if(isNil "DAC_Radio_Max")		then {		DAC_Radio_Max		= DAC_AI_Level;								};

	DAC_BadBuildings 	= 	[];
	DAC_GunNotAllowed	= 	[];
	DAC_VehNotAllowed	= 	[];
	DAC_Locked_Veh		=	[];
	DAC_SP_Soldiers     =   ["B_soldier_AR_F","B_G_soldier_AR_F","O_soldier_AR_F","O_soldierU_AR_F","O_G_soldier_AR_F","I_soldier_AR_F","I_G_soldier_AR_F"];
	DAC_Data_Array 		= 	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,[]];
	DAC_Marker_Val		= 	[];
	DAC_Zones			=	[];

	//=============================================================================================================|

    [] spawn (compile preprocessFileLineNumbers "DAC\Scripts\DAC_Start_Creator.sqf");
