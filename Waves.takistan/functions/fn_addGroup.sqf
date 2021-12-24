
						["--addGroup loaded"] remoteExec ["systemChat", [0, -2] select isDedicated];

params ["_wave", "_enemies", "_targets", "_classes", "_arrBaseTargets"];

// Add some randomness if more than 2 enemies in a group
if(_enemies > 2) then {
	fixedEnemies = selectRandom [_enemies-1, _enemies, _enemies+1];
} else {
	fixedEnemies = _enemies;
};

_group = createGroup east;
_pos = position selectRandom _targets;

// spawn enemies to group
for [{private _i = 0}, {_i < fixedEnemies}, {_i = _i + 1}] do {
	_group createUnit [selectRandom _classes, _pos, [], 50, "NONE"];
};

_wp = _group addWaypoint [position selectRandom _arrBaseTargets, 0];
_wp setWaypointType "SAD";
