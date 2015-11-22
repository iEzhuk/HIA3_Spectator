/*
    Name: HIA3_spectator_fnc_rotateCamera

    Author(s):
        Ezhuk

    Description:
        Rotate free camera

    Parameters:
        0 - x delta position (horizont)
        1 - y delta position (vertical)

    Returns:
        Nothing
*/
#include "defines.sqf"

PR(_dH) = _this select 0;
PR(_dV) = _this select 1;

PR(_mult) = if (KEY_LCONTROL in HIA3_Spectator_Keys) then {0.7} else {2};


switch (true) do {
    case (HIA3_Spectator_State==SPECT_VIEWSTATE_ATTACH and HIA3_Spectator_ViewUnit != vehicle HIA3_Spectator_ViewUnit) : {
        HIA3_Spectator_Camera_AngV = (HIA3_Spectator_Camera_AngV - _dV*HIA3_Spectator_Fov*_mult) max -89.9 min 89.9;
        HIA3_Spectator_AttachCam_Angle = (HIA3_Spectator_AttachCam_Angle + _dH*HIA3_Spectator_Fov*_mult) % 360;

        _newVectorUP =  [
            cos(90-HIA3_Spectator_AttachCam_Angle) * cos(HIA3_Spectator_Camera_AngV+90),
            sin(90-HIA3_Spectator_AttachCam_Angle) * cos(HIA3_Spectator_Camera_AngV+90),
            sin(HIA3_Spectator_Camera_AngV+90)
        ];

        HIA3_Spectator_Camera setDir HIA3_Spectator_AttachCam_Angle;
        HIA3_Spectator_Camera setVectorUp _newVectorUP;
        HIA3_Spectator_Camera camCommit 0;
    };
    default {
        HIA3_Spectator_Camera_AngV = (HIA3_Spectator_Camera_AngV - _dV*HIA3_Spectator_Fov*_mult) max -89.9 min 89.9;

        HIA3_Spectator_Camera setDir (getDir HIA3_Spectator_Camera + _dH*HIA3_Spectator_Fov*_mult);
        [
            HIA3_Spectator_Camera,
            HIA3_Spectator_Camera_AngV,
            0
        ] call bis_fnc_setpitchbank;
        HIA3_Spectator_Camera camCommitPrepared 0;
    };
};
