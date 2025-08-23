extends Node

var appid : int = 2835570

func _ready():
	process_priority = 1000
	set_process_internal(true)
	_initialize_steam()

func _process(_delta: float) -> void:
	if _should_use_steam():
		Steam.run_callbacks()

func _initialize_steam() -> void:
	if not _should_use_steam():
		print("Skipping Steam initialization (unsupported platform).")
		return

	OS.set_environment("SteamAppId", str(appid))
	OS.set_environment("SteamGameId", str(appid))

	var init: Dictionary = Steam.steamInit(false)
	print("Steam init: ", str(init))

func _should_use_steam() -> bool:
	var name := OS.get_name()
	# Steam SDK is only valid on Windows/Linux (not macOS, iOS, Android)
	return name == "Windows" or name == "Linux" or name == "UWP"
