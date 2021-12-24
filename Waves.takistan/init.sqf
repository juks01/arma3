/* Start waves */


if (isDedicated || isServer) then {
	_waves = execVM "functions\fn_startWaves.sqf";
};
