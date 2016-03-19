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

private _pos = [0,0,0];
if !(isNil {HIA3_Spectator_ViewUnit}) then {
    if (HIA3_Spectator_State == SPECT_VIEWSTATE_INTERNAL) then {
        _pos = getPos vehicle HIA3_Spectator_ViewUnit;
    } else {
        _pos = getPos HIA3_Spectator_Camera;
    };
};
_pos
