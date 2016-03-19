/*
    Name: HIA3_spectator_fnc_traceBullet

    Author(s):
        Ezhuk

    Description:

    Parameters:
        0: OBJECT - unit who's bullets will be visualized
        1: (Optional) NUMBER - max trajectories (default 10)
    Returns:
        Nothing
 */
params [["_shooter", objNull], ["_maxLines", 10]];

switch (true) do {
    case (_maxLines <= 0): {
        if ((count (_shooter getVariable ["SPECT_BT_Fired",[]])) != 0) then {
            _shooter removeEventHandler ["Fired", (_shooter getVariable "SPECT_BT_Fired") select 0];
        };

        _shooter setVariable ["SPECT_BT_maxLines", nil];
        _shooter getVariable ["SPECT_BT_Fired", []];
        _shooter setVariable ["SPECT_BT_Lines", []];
        _shooter setVariable ["SPECT_BT_colors", []];
        _shooter setVariable ["SPECT_BT_flying", nil];
        HIA3_Spectator_TraceBulletList = HIA3_Spectator_TraceBulletList - [_shooter];
    };
    default {
        _shooter setVariable ["SPECT_BT_maxLines", _maxLines];
        _shooter setVariable ["SPECT_BT_lines", []];
        _shooter setVariable ["SPECT_BT_colors", []];
        _shooter setVariable ["SPECT_BT_flying", 0];

        {_shooter removeEventHandler ["Fired", _x];} foreach (_shooter getVariable ["SPECT_BT_Fired",[]]);

        private _event = _shooter addEventHandler ["Fired", {[_this select 0, position (_this select 6), _this select 6] spawn HIA3_spectator_fnc_bulletTrace_fired;}];
        _shooter setVariable ["SPECT_BT_Fired", [_event]];

        if !(_shooter in HIA3_Spectator_TraceBulletList) then {
            HIA3_Spectator_TraceBulletList pushback _shooter;
        };
    };
};
