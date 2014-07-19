/*
	Name: HIA3_spectator_fnc_stopCam  
	
	Author(s):
		Ezhuk

	Description:
		Immediately stops the camera

	Parameters:
		Nothing

	Returns:
		Nothing
*/
#include "defines.sqf"
if(HIA3_Spectator_State == SPECT_VIEWSTATE_FREE) then {
	systemChat "STATE";
	if({_x in [KEY_W,KEY_A,KEY_S,KEY_D,KEY_Q,KEY_Z]} count HIA3_Spectator_Keys == 0) then {
		systemChat "COUNT";
		private ["_pos"];
		_pos = getPosATL HIA3_Spectator_Camera;
		HIA3_Spectator_Camera camSetPos _pos;
		HIA3_Spectator_Camera camCommit 0;
	};
};