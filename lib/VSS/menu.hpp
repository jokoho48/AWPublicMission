#include "resource.hpp"

class VSS_Menu
{
    idd = 18000;
    name = "VSS_Menu";
    movingEnabled = false;
    enableSimulation = true;
    onLoad = "[0] spawn JK_VSS_fnc_menu;";

    class controlsBackground
    {
        class titleBackground : VVS_RscText
        {
            idc = -1;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            x = 0.1;
            y = 0.2;
            w = 0.8;
            h = (1 / 25);
        };

        class MainBackground : VVS_RscText
        {
            idc = -1;
            colorBackground[] = {0,0,0,0.76};
            x = 0.1;
            y = 0.2 + (11 / 250);
            w = 0.8;
            h = 0.6 - (22 / 250);
        };

        class Footer : VVS_RscText
        {
            idc = -1;
            colorBackground[] = {0,0,0,0.8};
            x = 0.1;
            y = 0.805;
            w = 0.8;
            h = (1 / 25);
        };

        class priceTag : VVS_RscText
        {
            idc = 18004;
            colorBackground[] = {0,0,0,0};
            text = "Select Vehicle!";
            sizeEx = 0.04;
            x = 0.105;
            y = 0.805;
            w = 0.8;
            h = (1 / 25);
        };

        class Title : VVS_RscTitle
        {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "Virtual Vehicle Spawner";
            x = 0.1;
            y = 0.2;
            w = 0.8;
            h = (1 / 25);
        };
    };

    class controls
    {
        class vehicleListNew : VVS_RscListNBox
        {
            idc = 18001;
            text = "";
            sizeEx = 0.04;
            drawSideArrows = false;
            idcLeft = -1;
            idcRight = -1;
            rowHeight = 0.050;
            x = 0.1; y = 0.26;
            w = 0.8; h = 0.49 (22 / 250);
            onLBSelChanged = "[1] call JK_VSS_fnc_menu;";
        };

        class FilterList : VVS_RscCombo
        {
            idc = 18002;
            colorBackground[] = {0,0,0,0.7};
            onLBSelChanged  = "[2] call JK_VSS_fnc_menu;";
            x = 0.244 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.8 - (1 / 25);
            w = 0.34; h = (1 / 25);
        };

        class ButtonClose : VVS_RscButtonMenu
        {
            idc = -1;
            text = "Close";
            onButtonClick = "closeDialog 0;";
            x = 0.1;
            y = 0.8 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class ButtonSettings : VVS_RscButtonMenu
        {
            idc = 18003;
            text = "Spawn";
            onButtonClick = "[3] call JK_VSS_fnc_menu;";
            x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.8 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };

    };
};
