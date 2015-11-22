#define IDD_SPECT_GUI           73300
#define IDC_SPECT_BUTTON_1      73301
#define IDC_SPECT_BUTTON_2      73302
#define IDC_SPECT_BUTTON_3      73303
#define IDC_SPECT_BUTTON_4      73304
#define IDC_SPECT_PLAYERLIST    73305
#define IDC_SPECT_VIEW          73306

class RscButton;
class RscListbox;

class RscHIA3SpectatorGUIext {
    movingEnable = 1;
    idd = IDD_SPECT_GUI;
    onLoad = "['init',_this] call HIA3_spectator_fnc_HandlerSpectGUI";
    onUnload = "['close',_this] call HIA3_spectator_fnc_HandlerSpectGUI";
    onKeyDown = "['disp_keyDown',_this] call HIA3_spectator_fnc_HandlerSpectGUI";
    class controls {
        class Button_Side_WEST: RscButton {
            colorBackground[] = {0, 0.3, 0.6, 0.75};
            idc = IDC_SPECT_BUTTON_1;
            x = 0.84 * safeZoneW+safeZoneX;
            y = 0.00 * safeZoneH+safeZoneY;
            w = 0.04 * safeZoneW;
            h = 0.03 * safeZoneH;
            action = "['update_playerlist',[west]] call HIA3_spectator_fnc_handlerSpectGUI";
        };
        class Button_Side_EAST: RscButton {
            colorBackground[] = {0.5, 0, 0, 0.75};
            idc = IDC_SPECT_BUTTON_2;
            x = 0.88 * safeZoneW+safeZoneX;
            y = 0.00 * safeZoneH+safeZoneY;
            w = 0.04 * safeZoneW;
            h = 0.03 * safeZoneH;
            action = "['update_playerlist',[east]] call HIA3_spectator_fnc_handlerSpectGUI";
        };
        class Button_Side_RES: RscButton {
            colorBackground[] = {0, 0.5, 0, 0.75};
            idc = IDC_SPECT_BUTTON_3;
            x = 0.92 * safeZoneW+safeZoneX;
            y = 0.00 * safeZoneH+safeZoneY;
            w = 0.04 * safeZoneW;
            h = 0.03 * safeZoneH;
            action = "['update_playerlist',[resistance]] call HIA3_spectator_fnc_handlerSpectGUI";
        };
        class Button_Side_CIV: RscButton {
            colorBackground[] = {1.0, 0.5, 0, 0.75};
            idc = IDC_SPECT_BUTTON_4;
            x = 0.96 * safeZoneW+safeZoneX;
            y = 0.00 * safeZoneH+safeZoneY;
            w = 0.04 * safeZoneW;
            h = 0.03 * safeZoneH;
            action = "['update_playerlist',[civilian]] call HIA3_spectator_fnc_handlerSpectGUI";
        };
        class PlayerList: RscListbox{
            idc = IDC_SPECT_PLAYERLIST;

            x = 0.84 * safeZoneW+safeZoneX;
            y = 0.03 * safeZoneH+safeZoneY;
            w = 0.16 * safeZoneW;
            h = 0.97 * safeZoneH;

            size    = 0.025;
            sizeEx  = 0.025;
            canDrag = 0;

            onLBSelChanged = "['playerList_lb_changed',_this] call HIA3_spectator_fnc_handlerSpectGUI;";
        };

    };

};
