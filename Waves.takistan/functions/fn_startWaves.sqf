						["startWaves loaded"] remoteExec ["systemChat", [0, -2] select isDedicated];

/*
Requirements in mission:
 -BLUFOR starting positions
 -objects for base locations:
   trgBase1, trgBase2, trgBase3, trgBase4
 -objects for enemy spawn locations names as:
   trgA1, trgA2, trgA3,
   trgB1, trgB2, trgB3,
   trgC1, trgC2, trgC3,
   trgD1, trgD2, trgD3
*/


// Unit/Target names -- Change these if you want
arrTargets = [ trgA1, trgA2, trgA3, trgB1, trgB2, trgB3, trgC1, trgC2, trgC3, trgD1, trgD2, trgD3 ];
arrBaseTargets = [ trgBase1, trgBase2, trgBase3, trgBase4 ];

// TODO: Loadout after respawn. Now it's some Vanilla default...
// TODO: Vanilla revive...
// TODO: Classes to own config file
//arrEnemyClasses = [ "O_Tura_defector_lxWS", "O_Tura_deserter_lxWS", "O_Tura_enforcer_lxWS", "O_Tura_hireling_lxWS", "O_Tura_scout_lxWS", "O_Tura_medic2_lxWS", "O_Tura_thug_lxWS", "O_Tura_watcher_lxWS" ];
arrEnemyClasses = [ "O_G_Soldier_F", "O_G_Soldier_AR_F", "O_G_medic_F", "O_G_Soldier_LAT_F", "O_G_Soldier_TL_F", "O_G_Soldier_F", "O_G_Soldier_F" ];
arrVehiclesLightArmored = [ "O_LSV_02_armed_F", "O_LSV_02_unarmed_F", "" ];
arrVehiclesLight = [ "O_Quadbike_01_F", "UK3CB_O_M1030_CSAT_B" ];
/* TODO: More enemy loadouts, hell yeah!
arrWeaps = [ // Enemy weaponry - more variation means more tactical looting
				["Zafir", "Zafir_ammo"],
				["MK200", "MK200_ammo"] 
			];
// arrWeapons (+ammo)
// arrTanks
*/


// Static vars (by PARAMETERS menu)
intStartingWave	= ["StartingWave", 1]	call BIS_fnc_getParamValue;
intWaves		= ["Waves", 10] 		call BIS_fnc_getParamValue;
intBaseDelay	= ["BaseDelay", 20] 	call BIS_fnc_getParamValue;
intUnitCap		= ["Unitcap", 0]	 	call BIS_fnc_getParamValue;
switch (["Difficulty", 4] call BIS_fnc_getParamValue) do {
	case 2: { AICurrentSkill = 0.2; };		// Easier
	case 4: { AICurrentSkill = 0.4; };		// Normal
	case 6: { AICurrentSkill = 0.6; };		// Harder
};
floatSkill		= "Difficulty" 	call BIS_fnc_getParamValue;
intStamina		= "Fatigue" 	call BIS_fnc_getParamValue;


// TODO: Intro - even just a wakeup blur would be nice


// Loop thro wanted num of waves
for [{private _i = intStartingWave}, {_i < intWaves+1}, {_i = _i + 1}] do {
	intWave = _i;
	intWaveDelay = intBaseDelay + intWave*2; // Formula for delay between waves

	// ** Countdown for wave to start **
	for [{private _t = intWaveDelay}, {_t > 0}, {_t = _t - 1}] do {
		sleep 1;
		format ["Wave %1 starting in %2s", str intWave, str _t] remoteExec ["hint", [0, -2] select isDedicated]; // Countdown message to every client
	};

	// ** EnemySpawn **
	[parseText ("<t font='PuristaBold' size='3'>Wave " + str intWave + " starting</t>"), [0, 0, 1, 1], nil, 5, 0.7, 0] spawn BIS_fnc_textTiles;
	
	// * Variable reset for every wave
	// First get num of human players
	private _headlessClients = entities "HeadlessClient_F";
	private _humanPlayers = allPlayers - _headlessClients;
	intPlayers = count _humanPlayers;

	// Los formulos magnificatos! Si!
	intGroups  = 1 + round ((intPlayers/3) + (intWave/2));				// Base enemy groups / wave
	intEnemies = 2 + floor ((intPlayers/3) + (intWave/4)) + intUnitCap;	// Base enemies / base group
	intBackups = floor (((intPlayers/2) + (intWave/6)) /2);				// Base enemy extra groups
	intLightV  = round (((intPlayers/2) + (intWave/4)) /2);				// Base enemy extra light vehicles

				format ["Groups: %1 Enemies: %2 Backups: %3 LightV: %4", str intGroups, str intEnemies, str intBackups, str intLightV] remoteExec ["hint", [0, -2] select isDedicated];

// TEST
	[intWave, arrVehiclesLightArmored, arrTargets, arrBaseTargets] call compile preprocessFileLineNumbers "functions\fn_addVehicle.sqf";
// TEST

	// Generate groups
	for [{private _j = 0}, {_j < intGroups}, {_j = _j + 1}] do {
		[intWave, intEnemies, arrTargets, arrEnemyClasses, arrBaseTargets] call compile preprocessFileLineNumbers "functions\fn_addGroup.sqf";
	};

	// Generate backup forces
	for [{private _j = 0}, {_j < intBackups}, {_j = _j + 1}] do {
		[intWave, arrVehiclesLightArmored, intEnemies, arrTargets, arrEnemyClasses, arrBaseTargets] call compile preprocessFileLineNumbers "functions\fn_addBackup.sqf";
	};

	// Generate light vehicles (bikes, etc)
	for [{private _j = 0}, {_j < intLightV}, {_j = _j + 1}] do {
		[intWave, arrVehiclesLight, arrTargets, arrBaseTargets] call compile preprocessFileLineNumbers "functions\fn_addLightVehicle.sqf";
	};

	waitUntil {({(side _x) == east} count allUnits) < 1}; // Wait for every enemy down
	[parseText ("<t font='PuristaBold' size='3'>Wave " + str intWave + " defeated</t><br />Time for some looting..."), [0, 0, 1, 1], nil, 10, 0.7, 0] spawn BIS_fnc_textTiles;
	sleep 1; // wait a sec so we don't create too fast infinite loop by accident
};


// Call mission end when all done
format ["MISSION COMPLETED", str intWave] remoteExec ["hint", [0, -2] select isDedicated]; // Mission completed message to every client
["end1", true, 3] remoteExec ["BIS_fnc_endMission", 0, true];




