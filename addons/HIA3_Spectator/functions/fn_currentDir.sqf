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

private _dir = 0;
if !(isNil {HIA3_Spectator_ViewUnit}) then {
    if (HIA3_Spectator_State == SPECT_VIEWSTATE_INTERNAL) then {
        _dir = getDir HIA3_Spectator_ViewUnit;
    } else {
        _dir = getDir HIA3_Spectator_Camera;
    };
};
_dir
