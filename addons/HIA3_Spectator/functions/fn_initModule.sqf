/*
    Name: HIA3_spectator_fnc_initModule

    Author(s):
        Ezhuk

    Description:
        Initialises variables based on module settings

    Parameters:

    Returns:
        Nothing
 */
#include "defines.sqf"

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
    HIA3_Spectator_Enable = false;
    HIA3_Spectator_ShowEnemy = _logic getVariable "ShowEnemy";
    HIA3_Spectator_Tag = _logic getVariable "Tag";
    HIA3_Spectator_FreeView = _logic getVariable "FreeView";
    HIA3_Spectator_FreeViewTI = _logic getVariable "FreeViewTI";
    HIA3_Spectator_SpecialAdmin = _logic getVariable "SpecialAdmin";
};
