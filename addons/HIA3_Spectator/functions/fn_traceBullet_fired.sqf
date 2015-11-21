/*
    Name: HIA3_spectator_fnc_traceBullet_fired

    Author(s):
        Ezhuk
 */
private ["_shooter","_start","_round","_startSpeed"];
_shooter = _this select 0;
_start = _this select 1;
_round = _this select 2;

_startSpeed = (velocity _round) call BIS_fnc_magnitude;

_shooter setVariable ["SPECT_BT_flying", (_shooter getVariable "SPECT_BT_flying") + 1    ];
_shooter setVariable ["SPECT_BT_colors", (_shooter getVariable "SPECT_BT_colors") + [[]] ];
_shooter setVariable ["SPECT_BT_lines",  (_shooter getVariable "SPECT_BT_lines")  + [[]] ];

_i = (count (_shooter getVariable "SPECT_BT_lines") - 1);

((_shooter getVariable "SPECT_BT_colors") select _i) set [0, [1,0,0,1]];
((_shooter getVariable "SPECT_BT_lines") select _i) set [0, _start];

if (count (_shooter getVariable "SPECT_BT_lines") > (_shooter getVariable "SPECT_BT_maxLines")) then {
    (_shooter getVariable "SPECT_BT_colors") set [(count (_shooter getVariable "SPECT_BT_colors")) - (_shooter getVariable "SPECT_BT_maxLines") - 1, []];
    (_shooter getVariable "SPECT_BT_lines") set [(count (_shooter getVariable "SPECT_BT_lines")) - (_shooter getVariable "SPECT_BT_maxLines") - 1, []];
};

while {!isNull _round && if (count (_shooter getVariable "SPECT_BT_lines") > 0 && count (_shooter getVariable "SPECT_BT_lines") >= _i) then {count ((_shooter getVariable "SPECT_BT_lines") select _i) > 0} else {FALSE}} do {
    _curSpd = (velocity _round) call BIS_fnc_magnitude;
    if (_curSpd > 0) then {
        _r = 2 - (_startSpeed / _curSpd);
        _b = (_startSpeed / _curSpd) - 1;
        ((_shooter getVariable "SPECT_BT_colors") select _i) set [count ((_shooter getVariable "SPECT_BT_colors") select _i), [_r,0,_b,1]];
        ((_shooter getVariable "SPECT_BT_lines") select _i) set [count ((_shooter getVariable "SPECT_BT_lines") select _i), position _round];


        if (_curSpd > 300) then {
            sleep 0.1;
        } else {
            sleep 0.5;
        };
    };
};

if (count (_shooter getVariable "SPECT_BT_lines") > 0) then {
    _shooter setVariable ["SPECT_BT_flying", (_shooter getVariable "SPECT_BT_flying") - 1];
    if ((_shooter getVariable "SPECT_BT_flying") == 0) then {
        _shooter setVariable ["SPECT_BT_colors", (_shooter getVariable "SPECT_BT_colors") - [[]]];
        _shooter setVariable ["SPECT_BT_lines", (_shooter getVariable "SPECT_BT_lines") - [[]]];
    };
};
