/*
 	Name: HIA3_spectator_fnc_sideToColor
 	
 	Author(s):
		Ezhuk

 	Description:
		Return color for side

	Parameters:
		0 - Side
		
 	Returns:
		STRING: Color
*/

private ["_side","_color"];

_side = _this select 0;
_color = "ColorBlack";

switch (_side) do 
{
	case WEST:		{_color = "ColorBlufor";};
	case EAST:		{_color = "ColorOpfor";};
	case RESISTANCE:{_color = "ColorIndependent";};
	case CIVILIAN:	{_color = "ColorCivilian";};
};

_color	