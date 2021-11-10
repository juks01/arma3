// You'll need object with name obj1 for this.
// A smoke gren will be orbitin that object.

[] spawn {
  orbObj = createSimpleObject ["\A3\Weapons_f\ammo\smokegrenade_white", [(getPosASL obj1 select 0)+2, ((getPosASL obj1 select 1)+2), (getPosASL obj1 select 2)+2]]; 
  i = 0; // degree counter. Basically 0-359.
  m = 2; // multiplayer for degrees - needed for adjusting step count and speed of movement
  d = 1; // distance to object (default = 1)
  h = 1; // height from player floor level

  while {true} do {
    orbObj setPosASLW [((getPosASL obj1 select 0) + sin(i/m)*d), ((getPosASL obj1 select 1) + cos(i/m)*d), (getPosASL obj1 select 2)+h]; 

    if(i > 360*m-1) then { i = 0; };
    i = i + 1;
    uiSleep 0.02;
  };
};
