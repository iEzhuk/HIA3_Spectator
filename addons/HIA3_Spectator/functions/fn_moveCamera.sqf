/*
    Name: HIA3_spectator_fnc_moveCamera

    Author(s):
        Ezhuk

    Description:
        Set position to camera

    Parameters:
        Nothing

    Returns:
        Nothing
*/
#include "defines.sqf"

params ["_disp", "_key", "_shift", "_ctrl", "_alt"];

private _dist = 7;
private _distZ = 4;

if(_ctrl)          then {_dist =   1; _distZ =   1;};
if(_alt)           then {_dist =  23; _distZ =  17;};
if(_shift)         then {_dist =  83; _distZ =  47;};
if(_shift && _alt) then {_dist = 577; _distZ = 173;};

private _curDir = direction HIA3_Spectator_Camera;
private _newPos = getPosAsl HIA3_Spectator_Camera;

if(KEY_W in HIA3_Spectator_Keys)then{ _newPos=[0  , _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
if(KEY_S in HIA3_Spectator_Keys)then{ _newPos=[180, _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
if(KEY_A in HIA3_Spectator_Keys)then{ _newPos=[-90, _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
if(KEY_D in HIA3_Spectator_Keys)then{ _newPos=[90 , _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};

if(KEY_Q in HIA3_Spectator_Keys)then{ _newPos=[0, 0,  _distZ, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
if(KEY_Z in HIA3_Spectator_Keys)then{ _newPos=[0, 0, -_distZ, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};

// check terrein height
_newPos set [2, (_newPos select 2) max (getterrainheightasl _newPos)];

if(surfaceIsWater _newPos)then{
    HIA3_Spectator_Camera camSetPos _newPos;
}else{
    HIA3_Spectator_Camera camSetPos (ASLtoATL _newPos);
};



HIA3_Spectator_Camera camCommitPrepared 0.5;
