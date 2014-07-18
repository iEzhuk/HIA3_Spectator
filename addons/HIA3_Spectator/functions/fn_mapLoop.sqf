/*
 	Name: HIA3_spectator_fnc_mapLoop
 	
 	Author(s):
		Ezhuk

 	Description:
		Map updater 

	Parameters:
		Nothing
		
 	Returns:
		Nothing
*/
#include "defines.sqf"

disableSerialization;

while {!(isNull findDisplay IDD_SPECTATOR_MAP_DISPLAY)} do {
	call HIA3_spectator_fnc_updateMarkers;
	sleep 0.3;
};

call HIA3_spectator_fnc_clearMapMarkers;