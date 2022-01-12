/* vim: syntax=C++ */
/*
	This is a tiny demo how to add menu items in ACE menu.

	* Requirements:
	-- object with variable name barrel1
	-- object with variable name barrel2

	* Functionality:
	-- you cant delete barrel2 if barrel1 exists
	-- remove barrel1, then you can remove barrel2
	-- hint commands used in every case so the code is quite self-instructive to modify to you needs

	* Example usecase: Refusing bombs etc which needs to be done in certain order.
*/


/* -- Create menu for first named object -- */
// Create base level menu item in ace menu
_action = ["ownMenu", "ObjActions", "", {}, {true}] call ace_interact_menu_fnc_createAction;	// Creating action to ace menu
[barrel1, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;		// Add action when ace menu item is selected

// Create sub level menu item under base level item
_action = ["ownAction","Destroy","",{[5, [],
	{hint "Finished!"; deleteVehicle barrel1;},
	{hint "Failure!"},
	"Deleting barrel."] call ace_common_fnc_progressBar;},
	{true}] call ace_interact_menu_fnc_createAction;
[barrel1, 0, ["ACE_MainActions", "ownMenu"], _action] call ace_interact_menu_fnc_addActionToObject;


/* -- Create menu for second named object -- */
// Create base level menu item in ace menu
_action = ["ownMenu", "ObjActions", "", {}, {true}] call ace_interact_menu_fnc_createAction;	// Creating action to ace menu
[barrel2, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;		// Add action when ace menu item is selected

// Create sub level menu item under base level item
_action = ["ownAction","Destroy","",{[5, [],
	{if(!alive barrel1) then { hint "Finished!"; deleteVehicle barrel2; } else { hint "Failure! Barrel1 exists." };},
	{hint "Failure! Action cancelled."},
	"Deleting barrel."] call ace_common_fnc_progressBar;},
	{true}] call ace_interact_menu_fnc_createAction;
[barrel2, 0, ["ACE_MainActions", "ownMenu"], _action] call ace_interact_menu_fnc_addActionToObject;


/* TODO: add animation to player when interacting with object
		// playMove "AinvPknlMstpSlayWrflDnon_medic";
*/
