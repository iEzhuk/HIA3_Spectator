/*
    Name: HIA3_spectator_fnc_keyDown_Attach

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
        SPECT_VIEWSTATE_ATTACH call HIA3_spectator_fnc_initNewCam;
    };
    case KEY_RIGHT :
    {
        [1] call HIA3_spectator_fnc_changeTargetUnit;
        SPECT_VIEWSTATE_ATTACH call HIA3_spectator_fnc_initNewCam;
    };
    case KEY_DOWN :
    {
        [-1] call HIA3_spectator_fnc_changeTargetUnit;
        SPECT_VIEWSTATE_ATTACH call HIA3_spectator_fnc_initNewCam;
    };
    case KEY_LEFT :
    {
        [-1] call HIA3_spectator_fnc_changeTargetUnit;
        SPECT_VIEWSTATE_ATTACH call HIA3_spectator_fnc_initNewCam;
    };
    case KEY_NUMPADENTER :
    {
        HIA3_Spectator_Camera_AngV = -10;
        HIA3_Spectator_AttachCam_Angle = 0;
        HIA3_Spectator_AttachCam_Pos = [0, -7, 3];
        HIA3_Spectator_Fov = 0.7;

        HIA3_Spectator_Camera attachTo [vehicle HIA3_Spectator_ViewUnit, HIA3_Spectator_AttachCam_Pos];
        HIA3_Spectator_Camera setDir HIA3_Spectator_AttachCam_Angle;
        HIA3_Spectator_Camera campreparefov HIA3_Spectator_Fov;

        HIA3_Spectator_Camera camcommitprepared 0;

        [0, 0] call HIA3_spectator_fnc_rotateCamera;
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
};
