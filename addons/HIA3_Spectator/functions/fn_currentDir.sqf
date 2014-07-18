/*
 	Name: HIA3_spectator_fnc_currentDir
 	
 	Author(s):
		Ezhuk

 	Description:
		Get current spectator direction

	Parameters:
		Nothing
		
 	Returns:
		VAR: direction
*/
#include "defines.sqf"
		
if !(isNil {HIA3_Spectator_ViewUnit}) then {
	PR(_dir) = if(HIA3_Spectator_State == SPECT_VIEWSTATE_INTERNAL)then{getDir HIA3_Spectator_ViewUnit}else{getDir HIA3_Spectator_Camera};
	_dir
}else{
	0
};