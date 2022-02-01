/*
	ACE kill counts
	by JukS
	WIP - todo: vehicles, planes, improvements...
*/

["ace_unconscious",
 { 
  params ["_unit", "_isUnconscious"]; 
  if (_isUnconscious) then { 
   _unit setVariable ["isKanttuvei", true, true];
   if( ((side _unit) getFriend (side player)) < 0.6 && {side _unit != CIVILIAN}) then {
      (format ["%1 is unconscious! -> Score +1", name _unit]) remoteExec ["systemChat", 2]; 
	  [player addPlayerScores [1, 0, 0, 0, 0]];
   } else {
	  (format ["%1 is unconscious! -> Score -1", name _unit]) remoteExec ["systemChat", 2]; 
      [player addPlayerScores [-1, 0, 0, 0, 0]];
	};
  };
 }  
] call CBA_fnc_addEventHandler;

{
    _x setVariable ["permSide", side _x, true]; // set variable
    _x addEventHandler ["Killed", { 
        params ["_killed", "_killer"];
        private _killedSide = _killed getVariable ["permSide", civilian]; // Get side from variable
        private _killerSide = side _killer; // Killer is human player and should be alive
        private _isKanttuvei = _killed getVariable ["isKanttuvei", false]; // Used to determine if killed was unconscious. Prevents double scores.

        if(!_isKanttuvei) then {
			if((_killedSide getFriend _killerSide) < 0.6 && {_killedSide != CIVILIAN}) then {
                _killer addPlayerScores [1, 0, 0, 0, 0]; // enclosing in brackets does not make sense -> removed them
            } else {
                _killer addPlayerScores [-1, 0, 0, 0, 0];
            };
        };
    }];
} forEach (allUnits - allPlayers); // only for AI

