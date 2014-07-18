/*
	Name: HIA3_spectator_fnc_rotateCamera
	
	Author(s):
		Ezhuk

	Description:
		Rotate free camera 

	Parameters:
		0 - x delta position (horizont)
		1 - y delta position (vertical)
		
	Returns:
		Nothing
*/
#include "defines.sqf"

PR(_dH) = _this select 0;
PR(_dV) = _this select 1;

HIA3_Spectator_Camera_AngV = (HIA3_Spectator_Camera_AngV - _dV*HIA3_Spectator_Fov*2) max -89.9 min 89.9;

HIA3_Spectator_Camera setDir (getDir HIA3_Spectator_Camera + _dH*HIA3_Spectator_Fov*2);
[
	HIA3_Spectator_Camera,
	HIA3_Spectator_Camera_AngV,
	0
] call bis_fnc_setpitchbank;
HIA3_Spectator_Camera camCommitPrepared 0;