/*
    Name: HIA3_spectator_fnc_keyDown_Internal

    Author(s):
        Ezhuk

    Description:
        KeyDown handler to control interlal camera

    Parameters:
        ARRAY

    Returns:
        Nothing
*/
#include "defines.sqf"

params ["_disp", "_key", "_shift", "_ctrl", "_alt"];

switch (_key) do
{
    case KEY_UP :
    {
        [1] call HIA3_spectator_fnc_changeTargetUnit;
        SPECT_VIEWSTATE_INTERNAL call HIA3_spectator_fnc_initNewCam;
    };
    case KEY_RIGHT :
    {
        [1] call HIA3_spectator_fnc_changeTargetUnit;
        SPECT_VIEWSTATE_INTERNAL call HIA3_spectator_fnc_initNewCam;
    };
    case KEY_DOWN :
    {
        [-1] call HIA3_spectator_fnc_changeTargetUnit;
        SPECT_VIEWSTATE_INTERNAL call HIA3_spectator_fnc_initNewCam;
    };
    case KEY_LEFT :
    {
        [-1] call HIA3_spectator_fnc_changeTargetUnit;
        SPECT_VIEWSTATE_INTERNAL call HIA3_spectator_fnc_initNewCam;
    };
    case KEY_D :
    {
        [1] call HIA3_spectator_fnc_changeTargetUnit;
        SPECT_VIEWSTATE_INTERNAL call HIA3_spectator_fnc_initNewCam;
    };
    case KEY_A :
    {
        [-1] call HIA3_spectator_fnc_changeTargetUnit;
        SPECT_VIEWSTATE_INTERNAL call HIA3_spectator_fnc_initNewCam;
    };
};
