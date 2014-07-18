/*
 	Name: HIA3_spectator_fnc_currentPosition
 	
 	Author(s):
		Ezhuk

 	Description:
		Get current spectator position

	Parameters:
		Nothing
		
 	Returns:
		ARRAY: position
*/
#include "defines.sqf"

if !(isNil {HIA3_Spectator_ViewUnit}) then {
	PR(_pos) = if(HIA3_Spectator_State == SPECT_VIEWSTATE_INTERNAL)then{getPos vehicle HIA3_Spectator_ViewUnit}else{getPos HIA3_Spectator_Camera};
	_pos
}else{
	[0,0,0]
};