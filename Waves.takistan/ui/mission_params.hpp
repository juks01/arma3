class Params
{
	class MissionOptions {
		title = "Mission options";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class Difficulty {
		title = "Difficulty"
		values[] = { 2, 4, 7 }; // Translates to 0.2, 0.4 and 0.7
		texts[] = { "Easier", "Default", "Harder" };
		default = 4;
	};
	class StartingWave {
		title = "Starting wave"
		values[] = { 1,   2,   3,   4,   5 };
		texts[] = { "1", "2", "3", "4", "5" };
		default = 1;
	};
	class Waves {
		title = "Waves"
		values[] = { 7,   10,   12,   15,   20 };
		texts[] = { "7", "10", "12", "15", "20" };
		default = 10;
	};
	class BaseDelay {
		title = "Base delay between waves (formula: base + 2*wave number)";
			values[] = { 0, 10, 20, 30, 40 };
		texts[] = { "0 seconds", "10 seconds", "20 seconds", "30 seconds", "40 seconds" };
		default = 20;
	};
	class Unitcap {
		title = "Units/group adjust";
		values[] = { -1, 0, 1, 2 };
		texts[] = { "-1", "0 (Default)", "+1", "+2" };
		default = 0;
	};
	class Fatigue {
		title = "Stamina";
		values[] = { 0, 1 };
		texts[] = { "Disabled", "Enabled" };
		default = 1;
	};

// TODO: Fatique disabling & Blufor defenders -b


/*
	class DayDuration {
		title = "Day duration"
		values[] = { 0, 1, 2, 4 };
		texts[] = { "Paused", "Normal", "2x", "4x" };
		default = 1;
	};
	class ShorterNights {
		title = "Shorter Nights"
		values[] = { 0, 1 };
		texts[] = { "Disabled", "Enabled" };
		default = 1;
	};
	class Spacer1 {
		title = "";
		values[] = { "" };
		texts[] = { "" };
		default = "";
	};
	class BluforDefenders {
		title = "Ally defenders";
		values[] = { 0, 1, 2, 3, 4, 5, 6 };
		texts[] = { "0", "1", "2", "3", "4", "5", "6" };
		default = 0;
	};
*/

};
