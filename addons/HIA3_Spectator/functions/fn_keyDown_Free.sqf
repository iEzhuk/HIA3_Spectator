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
	case KEY_X : 
	{
		if(count HIA3_Spectator_UnitList > 0) then {
			
			PR(_curPos) = call HIA3_spectator_fnc_currentPosition;
			PR(_nearestUnit) = nullObj;
			PR(_dist) = 10000;

			for "_i" from 0 to ((count HIA3_Spectator_UnitList)-1) do {
				PR(_unit) = HIA3_Spectator_UnitList select _i;
				PR(_unitPos) = getPos _unit;
				PR(_newDist) = [_curPos select 0, _curPos select 1, 0] distance [_unitPos select 0, _unitPos select 1, 0];

				if (_newDist < _dist) then {
					_dist = _newDist;
					_nearestUnit = _unit;
				};	
			};

			if (_dist < 500) then {
				[_nearestUnit] call HIA3_spectator_fnc_changeTargetUnit;
				SPECT_VIEWSTATE_INTERNAL call HIA3_spectator_fnc_initNewCam;
			};
		};
	};
};

_this call HIA3_spectator_fnc_moveCamera;

