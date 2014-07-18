/*
 	Name: HIA3_spectator_fnc_keyDown_Free
 	
 	Author(s):
		Ezhuk

 	Description:
		KeyDown handler to control free camera  
	
	Parameters:
		ARRAY
 	
 	Returns:
		Nothing
*/
#include "defines.sqf"

PR(_key)	= _this select 1;
PR(_shift)	= _this select 2;
PR(_ctrl)	= _this select 3;
PR(_alt)	= _this select 4;

switch (_key) do
{
	case KEY_UP : 
	{
		[1] call HIA3_spectator_fnc_changeTargetUnit;
	};
	case KEY_RIGHT : 
	{
		[1] call HIA3_spectator_fnc_changeTargetUnit;
	};
	case KEY_DOWN : 
	{
		[-1] call HIA3_spectator_fnc_changeTargetUnit;
	};
	case KEY_LEFT : 
	{
		[-1] call HIA3_spectator_fnc_changeTargetUnit;
	};
	case KEY_RIGHT : 
	{
		[1] call HIA3_spectator_fnc_changeTargetUnit;
	};
	case KEY_ADD : 
	{
		HIA3_Spectator_Fov = (HIA3_Spectator_Fov*0.98) max 0.02;
		HIA3_Spectator_Camera campreparefov HIA3_Spectator_Fov;
		HIA3_Spectator_Camera camcommitprepared 0;
	};
	case KEY_SUBTRACT : 
	{
		HIA3_Spectator_Fov = (HIA3_Spectator_Fov*1.02) min 1;
		HIA3_Spectator_Camera campreparefov HIA3_Spectator_Fov;
		HIA3_Spectator_Camera camcommitprepared 0;
	};
	case KEY_NUMPADENTER : 
	{
		HIA3_Spectator_Fov = 0.7;
		HIA3_Spectator_Camera campreparefov HIA3_Spectator_Fov;
		HIA3_Spectator_Camera camcommitprepared 0;
	};
};

_this call HIA3_spectator_fnc_moveCamera;