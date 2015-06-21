/*
 	Name: HIA3_spectator_fnc_switchCameraState
 	
 	Author(s):
		Ezhuk

 	Description:
		Change state of camera 
	
	Parameters:
		Nothing 
 	
 	Returns:
		Nothing
*/
#include "defines.sqf"

switch(HIA3_Spectator_State) do {
	case SPECT_VIEWSTATE_INTERNAL : 
	{
		if(HIA3_Spectator_FreeView || (HIA3_Spectator_SpecialAdmin && serverCommandAvailable('#kick')) ) then {
			if (HIA3_Spectator_Keys find KEY_LCONTROL != -1) then {
				SPECT_VIEWSTATE_ATTACH call HIA3_spectator_fnc_initNewCam;
			} else {
				SPECT_VIEWSTATE_FREE call HIA3_spectator_fnc_initNewCam;
			};
		};
	};
	case SPECT_VIEWSTATE_ATTACH : 
	{
		if(HIA3_Spectator_FreeView || (HIA3_Spectator_SpecialAdmin && serverCommandAvailable('#kick')) ) then {
			SPECT_VIEWSTATE_FREE call HIA3_spectator_fnc_initNewCam;
		};
	};
	case SPECT_VIEWSTATE_FREE : 
	{	
		SPECT_VIEWSTATE_INTERNAL call HIA3_spectator_fnc_initNewCam;
	};

};
