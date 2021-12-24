
params ["_wave", "_vehicleslightarmored", "_enemies", "_targets", "_classes", "_arrBaseTargets"];

// 50/50 change to call a group or a vehicle
if(selectRandom [TRUE,FALSE]) then {
	[_wave, _vehicleslightarmored, _targets, _arrBaseTargets] call compile preprocessFileLineNumbers "functions\fn_addVehicle.sqf";
} else {
	[_wave, _enemies, _targets, _classes, _arrBaseTargets] call compile preprocessFileLineNumbers "functions\fn_addGroup.sqf";
};


