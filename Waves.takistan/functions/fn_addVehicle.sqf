
						["--addVehicle loaded"] remoteExec ["systemChat", [0, -2] select isDedicated];

params ["_wave", "_vehicleslightarmored", "_targets", "_arrBaseTargets"];

private _veh = createVehicle [selectRandom _vehicleslightarmored, position selectRandom _targets, [], 20, "NONE"];
private _grp = createVehicleCrew _veh;

// TODO: Select vehicle crew from (?) or from _enemies?

// private _grp = group commander _veh;	
private _wp = _grp addWaypoint [position selectRandom _arrBaseTargets, 0];
_wp setWaypointType "SAD";
