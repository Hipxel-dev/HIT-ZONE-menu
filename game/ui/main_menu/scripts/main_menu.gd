extends Node2D

enum states {
	LOGO,
	TITLE_SCEEN,
	MAIN_MENU,
	SETTINGS,
	EXTRAS,
	SAVE_FILE_SELECT
}

var current_state = states.LOGO
