
						["--addLightVehicle loaded"] remoteExec ["systemChat", [0, -2] select isDedicated];

params ["_wave", "_vehicleslight", "_targets", "_arrBaseTargets"];

_veh = createVehicle [selectRandom _vehicleslight, position selectRandom _targets, [], 20, "NONE"];
private _grp = createVehicleCrew _veh;

// TODO: Select vehicle crew from (?) or from _enemies?

// private _grp = group commander _veh;	
private _wp = _grp addWaypoint [position selectRandom _arrBaseTargets, 0];
_wp setWaypointType "SAD";
