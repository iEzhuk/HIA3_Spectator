/*
 	Name: HIA3_spectator_fnc_mapDraw
 	
 	Author(s):
		Ezhuk

 	Description:
		Drawing on map on each frame 

	Parameters:
		Nothing

 	Returns:
		Nothing
*/
#include "defines.sqf"

if(isNil "HIA3_Spectator_CamVision") exitWith {};

PR(_posCam) = call HIA3_spectator_fnc_currentPosition;
PR(_dirCam) = call HIA3_spectator_fnc_currentDir;
PR(_iconCam)= gettext (configfile >> "RscDisplayCamera" >> "iconCamera");
PR(_colorCam) = [side HIA3_Spectator_ViewUnit] call BIS_fnc_sideColor;
_ctrlMap = _this select 0;

if !(isNil {HIA3_Spectator_ViewUnit}) then {
	// target icon 
	_ctrlMap drawIcon ["\A3\ui_f\data\igui\cfg\islandmap\iconplayer_ca.paa",[0.7,0,0,1],getPos (vehicle HIA3_Spectator_ViewUnit),24,24,0,"",0,0.03,"PuristaMedium","right"];
};

// camera icon 
if(HIA3_Spectator_State == SPECT_VIEWSTATE_INTERNAL) then {
	_ctrlMap drawIcon [_iconCam,_colorCam,_posCam,28,28,_dirCam,"",1,0.03,"PuristaMedium","right"];
}else{
	_ctrlMap drawIcon [_iconCam,_colorCam,_posCam,32,32,_dirCam,"",1,0.03,"PuristaMedium","right"];
};