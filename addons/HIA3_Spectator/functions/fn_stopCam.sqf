/*
    Name: HIA3_spectator_fnc_stopCam

    Author(s):
        Ezhuk

    Description:
        Immediately stops the free camera

    Parameters:
        Nothing

    Returns:
        Nothing
*/
#include "defines.sqf"

if (HIA3_Spectator_State == SPECT_VIEWSTATE_FREE) then {
    if({_x in [KEY_W,KEY_A,KEY_S,KEY_D,KEY_Q,KEY_Z]} count HIA3_Spectator_Keys == 0) then {
        if (not camCommitted HIA3_Spectator_Camera) then {
            private ["_pos"];
            _pos = getPosATL HIA3_Spectator_Camera;
            _pos = if (surfaceIsWater _pos) then {getPos HIA3_Spectator_Camera} else {getPosATL HIA3_Spectator_Camera};
            HIA3_Spectator_Camera camSetPos _pos;
            HIA3_Spectator_Camera camCommit 0;
        };
    };
};
