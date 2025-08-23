extends Node

var appid: int = 2835570

func _ready():
	process_priority = 1000
	set_process_internal(true)
	_initialize_steam()

func _process(_delta: float) -> void:
	if Engine.has_singleton("Steam"):
		var steam = Engine.get_singleton("Steam")
		steam.run_callbacks()

func _initialize_steam() -> void:
	if not Engine.has_singleton("Steam"):
		print("Skipping Steam initialization (Steam not available on this platform).")
		return

	var steam = Engine.get_singleton("Steam")
	OS.set_environment("SteamAppId", str(appid))
	OS.set_environment("SteamGameId", str(appid))
	var init: Dictionary = steam.steamInit(false)
	print("Steam init: ", str(init))
