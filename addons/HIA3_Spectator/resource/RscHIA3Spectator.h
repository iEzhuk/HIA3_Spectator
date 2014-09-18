#define IDD_SPECTATOR_DISPLAY 10000
#define IDD_SPECTATOR_PLAYER_NAME 10001
#define IDD_SPECTATOR_TIME 10002
#define IDD_SPECTATOR_CREW 10003
#define IDD_SPECTATOR_COUNT0 10010
#define IDD_SPECTATOR_COUNT1 10011
#define IDD_SPECTATOR_COUNT2 10012
#define IDD_SPECTATOR_COUNT3 10013
#define IDD_SPECTATOR_HELP 10030

#define IDD_SPECTATOR_MAP_DISPLAY 10100
#define IDD_SPECTATOR_MAP_MAP 51

#define ST_LEFT           0x00
#define ST_CENTER         0x02

class RscMap;
class RscMapControl;
class RscText;
class RscStructuredText;

class RscTitles
{
	class RscHIA3Specator {
		idd				= IDD_SPECTATOR_DISPLAY;
		fadeout			= 0;
		fadein			= 0;
		duration		= 1000000;
		onLoad 			= "['init',_this] call HIA3_spectator_fnc_handler";
		onUnload 		= "['close',_this] call HIA3_spectator_fnc_handler";
		class controls {
			class PlayerName: RscText
			{
				idc = IDD_SPECTATOR_PLAYER_NAME;
				x 	= 0.00 * safezoneW + safezoneX;
				y 	= 0.97 * safezoneH + safezoneY;
				w 	= 0.25 * safezoneW;
				h 	= 0.03 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};
			class Time: RscText
			{
				idc = IDD_SPECTATOR_TIME;
				style = ST_CENTER;
				x 	= 0.25 * safezoneW + safezoneX;
				y 	= 0.97 * safezoneH + safezoneY;
				w 	= 0.06 * safezoneW;
				h 	= 0.03 * safezoneH;
				colorBackground[] = {0,0,0,1};
			};
			class Crew: RscStructuredText
			{
				idc = IDD_SPECTATOR_CREW;
				style = ST_LEFT;
				x 	= 0.00 * safezoneW + safezoneX;
				y 	= 0.40 * safezoneH + safezoneY;
				w 	= 0.40 * safezoneW;
				h 	= 0.27 * safezoneH;
				sizeEx 	= 0.02;
				size 	= 0.02;
				text 	= "";
				colorBackground[] = {0,0,0,0};
			};
			class count0: RscText
			{
				idc = IDD_SPECTATOR_COUNT0;
				style = ST_CENTER;
				x 	= 0.31 * safezoneW + safezoneX;
				y 	= 0.97 * safezoneH + safezoneY;
				w 	= 0.03 * safezoneW;
				h 	= 0.03 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};
			class count1: RscText
			{
				idc = IDD_SPECTATOR_COUNT1;
				style = ST_CENTER;
				x 	= 0.34 * safezoneW + safezoneX;
				y 	= 0.97 * safezoneH + safezoneY;
				w 	= 0.03 * safezoneW;
				h 	= 0.03 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};
			class count2: RscText
			{
				idc = IDD_SPECTATOR_COUNT2;
				style = ST_CENTER;
				x 	= 0.37 * safezoneW + safezoneX;
				y 	= 0.97 * safezoneH + safezoneY;
				w 	= 0.03 * safezoneW;
				h 	= 0.03 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};
			class count3: RscText
			{
				idc = IDD_SPECTATOR_COUNT3;
				style = ST_CENTER;
				x 	= 0.40 * safezoneW + safezoneX;
				y 	= 0.97 * safezoneH + safezoneY;
				w 	= 0.03 * safezoneW;
				h 	= 0.03 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};                                                                       
			class Help: RscStructuredText
			{
				idc = IDD_SPECTATOR_HELP;
				x 	= 0.20 * safezoneW + safezoneX;
				y 	= 0.10 * safezoneH + safezoneY;
				w 	= 0.60 * safezoneW;
				h 	= 0.80 * safezoneH;
				sizeEx 	= 0.03;
				size 	= 0.03;
				colorBackground[] = {0,0,0,0.4};
				text = $STR_HIA3_Spectator_Help;
			};
		};
	};
};

class RscHIA3Specator_Map: RscMap {
	idd = 10100;
	onLoad = "['init',_this] call HIA3_spectator_fnc_mapHandler";
	onUnload = "['close',_this] call HIA3_spectator_fnc_mapHandler";
	onKeyUp = "['keyUp',_this] call HIA3_spectator_fnc_mapHandler";
	class controls {
		class Map : RscMapControl{
			x 	= 0.0 * safezoneW + safezoneX;
			y 	= 0.0 * safezoneH + safezoneY;
			w 	= 1.0 * safezoneW;
			h 	= 1.0 * safezoneH;
			sizeExNames = 0.044;
		};
	};
};