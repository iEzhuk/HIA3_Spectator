/*
 	Name: HIA3_spectator_fnc_attachedCamera
 	
 	Author(s):
		Ezhuk

 	Description:
	
	Parameters:

 	Returns:
*/
#include "defines.sqf"
// Time between two frame 
PR(_d) = HIA3_Spectator_LastFrameTime - _last_time;

if(_d < 0.3) then {
	PR(_curDir) = HIA3_Spectator_AttachCam_Angle;
	PR(_newPos) = HIA3_Spectator_AttachCam_Pos;


	PR(_mult) = switch (true) do {
					case (KEY_LCONTROL in HIA3_Spectator_Keys) : {2};
					case (KEY_LSHIFT in HIA3_Spectator_Keys) : {10};
					default {5};
				};

	PR(_dist) = _mult*_d;

	if(KEY_W in HIA3_Spectator_Keys) then { _newPos=[0  , _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
	if(KEY_S in HIA3_Spectator_Keys) then { _newPos=[180, _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
	if(KEY_A in HIA3_Spectator_Keys) then { _newPos=[-90, _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
	if(KEY_D in HIA3_Spectator_Keys) then { _newPos=[90 , _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};

	if(KEY_Q in HIA3_Spectator_Keys) then { _newPos=[0, 0,  _dist, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
	if(KEY_Z in HIA3_Spectator_Keys) then { _newPos=[0, 0, -_dist, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};

	PR(_wpos) = (vehicle HIA3_Spectator_ViewUnit) modelToWorld _newPos;
	if (surfaceIsWater _wPos) then {
		PR(_tpos) = ASLToATL _wPos;
		if (_tpos select 2 < 0) then {
			_newPos set[2, (_newPos select 2) - (_tpos select 2)];
		};
	} else {
		if (_wpos select 2 < 0) then {
			_newPos set[2, (_newPos select 2) - (_wpos select 2)];
		};
	};

	HIA3_Spectator_AttachCam_Pos = _newPos;
	HIA3_Spectator_Camera attachTo [vehicle HIA3_Spectator_ViewUnit, HIA3_Spectator_AttachCam_Pos];
};