/*
    Name: HIA3_spectator_fnc_mapLoop

    Author(s):
        Ezhuk

    Description:
        Map updater

    Parameters:
        Nothing

    Returns:
        Nothing
*/
#include "defines.sqf"

disableSerialization;

while {true} do {

    if(isNull findDisplay IDD_SPECTATOR_MAP_DISPLAY) then {
        call HIA3_spectator_fnc_clearMapMarkers;
    } else {
        call HIA3_spectator_fnc_updateMarkers;
    };

    sleep 0.2;
};
