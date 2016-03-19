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

params ["_disp", "_key", "_shift", "_ctrl", "_alt"];

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

            private _curPos = call HIA3_spectator_fnc_currentPosition;
            private _nearestUnit = nullObj;
            private _dist = 10000;

            private ["_unit", "_unitPos", "_newDist"];
            for "_i" from 0 to ((count HIA3_Spectator_UnitList)-1) do {
                _unit = HIA3_Spectator_UnitList select _i;
                _unitPos = getPos _unit;
                _newDist = [_curPos select 0, _curPos select 1, 0] distance [_unitPos select 0, _unitPos select 1, 0];

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
