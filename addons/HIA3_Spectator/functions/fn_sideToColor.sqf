/*
    Name: HIA3_spectator_fnc_sideToColor

    Author(s):
        Ezhuk

    Description:
        Return color for side

    Parameters:
        0 - Side

    Returns:
        STRING: Color
*/
params ["_side"];

switch (_side) do
{
    case WEST:       {"ColorBlufor"};
    case EAST:       {"ColorOpfor"};
    case RESISTANCE: {"ColorIndependent"};
    case CIVILIAN:   {"ColorCivilian"};
    default          {"ColorBlack"};
};
