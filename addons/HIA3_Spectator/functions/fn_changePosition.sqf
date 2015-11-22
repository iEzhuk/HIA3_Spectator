/*
    Name: HIA3_spectator_fnc_changePosition

    Author(s):
        Ezhuk

    Description:
        Change position by direction and distance

    Parameters:
        0 - direction
        1 - distance
        2 - offset Z position
        3 - current position
        4 - current direction

    Returns:
        new position
*/
#include "defines.sqf"

PR(_angl) = _this select 0;
PR(_dist) = _this select 1;
PR(_dZ) = _this select 2;
PR(_pos) = _this select 3;
PR(_dir) = _this select 4;

PR(_newPos) = [
    (_pos select 0) + ((sin (_dir+_angl)) * _dist),
    (_pos select 1) + ((cos (_dir+_angl)) * _dist),
    (_pos select 2) + _dZ
];

_newPos
