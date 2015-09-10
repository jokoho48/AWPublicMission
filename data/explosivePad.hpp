class KeypadDefuse
{
	idd = -1;
	movingEnable = 1;
    enableSimulation = 1;
	controlsBackground[] = {};
  	objects[] = {};

	class controls
	{
		class B9: RscButton
		{
			idc = -1;
			x = 0.53197 * safezoneW + safezoneX;
			y = 0.5924 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput pushBack 9; ctrlSetText [1099, (ctrlText 1099) + str 9]";
		};
		class B8: RscButton
		{
			idc = -1;
			x = 0.504125 * safezoneW + safezoneX;
			y = 0.5924 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput pushBack 8; ctrlSetText [1099, (ctrlText 1099) + str 8]";
		};
		class B7: RscButton
		{
			idc = -1;
			x = 0.476148 * safezoneW + safezoneX;
			y = 0.592356 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput pushBack 7; ctrlSetText [1099, (ctrlText 1099) + str 7]";
		};
		class B6: RscButton
		{
			idc = -1;
			x = 0.532441 * safezoneW + safezoneX;
			y = 0.64143 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput pushBack 6; ctrlSetText [1099, (ctrlText 1099) + str 6]";
		};
		class B5: RscButton
		{
			idc = -1;
			x = 0.504273 * safezoneW + safezoneX;
			y = 0.643052 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput pushBack 5; ctrlSetText [1099, (ctrlText 1099) + str 5]";
		};
		class B4: RscButton
		{
			idc = -1;
			x = 0.47525 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput pushBack 4; ctrlSetText [1099, (ctrlText 1099) + str 4]";
		};
		class B3: RscButton
		{
			idc = -1;
			x = 0.531963 * safezoneW + safezoneX;
			y = 0.691778 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput pushBack 3; ctrlSetText [1099, (ctrlText 1099) + str 3]";
		};
		class B2: RscButton
		{
			idc = -1;
			x = 0.504752 * safezoneW + safezoneX;
			y = 0.692704 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput pushBack 2; ctrlSetText [1099, (ctrlText 1099) + str 2]";
		};
		class B1: RscButton
		{
			idc = -1;
			x = 0.476095 * safezoneW + safezoneX;
			y = 0.691778 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput pushBack 1; ctrlSetText [1099, (ctrlText 1099) + str 1]";
		};
		class B0: RscButton
		{
			idc = -1;
			x = 0.504124 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput pushBack 0; ctrlSetText [1099, (ctrlText 1099) + str 0]";
		};
		class Benter: RscButton
		{
			idc = -1;
			x = 0.532898 * safezoneW + safezoneX;
			y = 0.740504 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "[SEN_codeDefuse, SEN_codeInput] spawn SEN_fnc_compareCode; closeDialog 0";
		};
		class Bclear: RscButton
		{
			idc = -1;
			x = 0.477313 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; SEN_codeInput = []; ctrlSetText [1099, str SEN_codeInput]";
		};
		class KeypadImage: RscPicture
		{
			idc = -1;
			moving = 1;
			type = CT_STATIC;
			style = ST_PICTURE;
			x = 0.142156 * safezoneW + safezoneX;
			y = -0.1446 * safezoneH + safezoneY;
			w = 0.721875 * safezoneW;
			h = 1.254 * safezoneH;
			text = "media\explosive.paa";
		};
		class NumberDisplay: RscStructuredText
		{
			idc = 1099;
			type = CT_STATIC;
			style = ST_LEFT;
			colorText[] = {0.2,0.4,0,1};
			colorBackground[] = { 1, 1, 1, 0 };
			font = EtelkaNarrowMediumPro;
			sizeEx = 0.072;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.3988 * safezoneH + safezoneY;
			w = 0.136116 * safezoneW;
			h = 0.0418 * safezoneH;
		};
		class Bblue: RscButton
		{
			idc = -1;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,0,1,1};
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'wire_cut'; [SEN_wireDefuse,'BLUE'] spawn SEN_fnc_compareWire; closeDialog 0";
		};
		class Bwhite: RscButton
		{
			idc = -1;
			x = 0.481437 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {1,1,1,1};
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'wire_cut'; [SEN_wireDefuse,'WHITE'] spawn SEN_fnc_compareWire; closeDialog 0";
		};
		class Byellow: RscButton
		{
			idc = -1;
			x = 0.521656 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {1,1,0,1};
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'wire_cut'; [SEN_wireDefuse,'YELLOW'] spawn SEN_fnc_compareWire; closeDialog 0";
		};
		class Bgreen: RscButton
		{
			idc = -1;
			x = 0.558781 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,1,0,1};
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'wire_cut'; [SEN_wireDefuse,'GREEN'] spawn SEN_fnc_compareWire; closeDialog 0";
		};
	};
};