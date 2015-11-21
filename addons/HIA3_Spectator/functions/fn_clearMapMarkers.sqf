/*
    Name: HIA3_spectator_fnc_clearMapMarkers

    Author(s):
        Ezhuk

    Description:
        Remove all added markers

    Parameters:
        Nothing

    Returns:
        Nothing
*/

if(count HIA3_Spectator_ObjMarkers > 0) then {
    HIA3_Spectator_ObjMarkers = [];
    {
        if(_x select [0,6] == "Spect_") then
        {
            deleteMarkerLocal _x;
        };
    } forEach allMapMarkers;
}
