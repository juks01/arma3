/*
	ACE kill counts
	by JukS
	WIP - todo: vehicles, planes, improvements...
*/

// When enemy gets unconscious
["ace_unconscious",
 { 
  params ["_unit", "_isUnconscious"]; 
  if (_isUnconscious) then { 
   _unit setVariable ["isKanttuvei", true, true];
  (format ["side: %1 / sideVeh: %2", side _unit, (side group _unit)]) remoteExec ["systemChat", 2];
   if((((side _unit) getFriend (side player)) < 0.6 && {side _unit != CIVILIAN }) || (((side group _unit) getFriend (side player)) < 0.6)) then {
      (format ["%1 is unconscious! -> Score +1", name _unit]) remoteExec ["systemChat", 2]; 
	  [player addPlayerScores [1, 0, 0, 0, 0]];
   } else {
	  (format ["%1 is unconscious! -> Score -1", name _unit]) remoteExec ["systemChat", 2]; 
      [player addPlayerScores [-1, 0, 0, 0, 0]];
	};
  };
 }  
] call CBA_fnc_addEventHandler;

// When enemy is killed
{
    _x setVariable ["permSide", side _x, true]; // set variable
    _x addEventHandler ["Killed", { 
        params ["_killed", "_killer"];
        private _killedSide = _killed getVariable ["permSide", civilian]; // Get side from variable
        private _killedSideVeh = side group _killed;
        private _killerSide = side _killer; // Killer is human player and should be alive
        private _isKanttuvei = _killed getVariable ["isKanttuvei", false]; // Used to determine if killed was unconscious. Prevents double scores.

        if(!_isKanttuvei) then {
			if(((_killedSide getFriend _killerSide) < 0.6 || (_killedSideVeh getFriend _killerSide) < 0.6)  && {_killedSide != CIVILIAN}) then {
                _killer addPlayerScores [1, 0, 0, 0, 0]; // enclosing in brackets does not make sense -> removed them
            } else {
                _killer addPlayerScores [-1, 0, 0, 0, 0];
            };
        };
    }];
} forEach (allUnits - allPlayers); // only for AI

