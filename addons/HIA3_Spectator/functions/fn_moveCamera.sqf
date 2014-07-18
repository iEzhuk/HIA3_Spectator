/*
	Name: HIA3_spectator_fnc_moveCamera
	
	Author(s):
		Ezhuk

	Description:
		Set position to camera 

	Parameters:
		Nothing

	Returns:
		Nothing
*/
#include "defines.sqf"

PR(_dist) = 13;	
PR(_distZ) = 9;

if(KEY_LSHIFT in HIA3_Spectator_Keys) then {_dist = 101;_distZ=57;};
if(KEY_LCONTROL in HIA3_Spectator_Keys) then {_dist=3;_distZ=2;};

PR(_curDir) = direction HIA3_Spectator_Camera;
PR(_newPos) = getPosAsl HIA3_Spectator_Camera;

if(KEY_W in HIA3_Spectator_Keys)then{_newPos=[0,_dist,0,_newPos,_curDir] call HIA3_spectator_fnc_changePosition;};
if(KEY_S in HIA3_Spectator_Keys)then{_newPos=[180,_dist,0,_newPos,_curDir] call HIA3_spectator_fnc_changePosition;};
if(KEY_A in HIA3_Spectator_Keys)then{_newPos=[-90,_dist,0,_newPos,_curDir] call HIA3_spectator_fnc_changePosition;};
if(KEY_D in HIA3_Spectator_Keys)then{_newPos=[90,_dist,0,_newPos,_curDir] call HIA3_spectator_fnc_changePosition;};

if(KEY_Q in HIA3_Spectator_Keys)then{_newPos=[0,0,_distZ,_newPos,_curDir] call HIA3_spectator_fnc_changePosition;};
if(KEY_Z in HIA3_Spectator_Keys)then{_newPos=[0,0,-_distZ,_newPos,_curDir] call HIA3_spectator_fnc_changePosition;};

if(surfaceIsWater _newPos)then{
	HIA3_Spectator_Camera camSetPos _newPos;
}else{
	HIA3_Spectator_Camera camSetPos (ASLtoATL _newPos);
};

HIA3_Spectator_Camera camCommitPrepared 0.5;