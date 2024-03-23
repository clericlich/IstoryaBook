extends Node

var settings = {}

func _ready():
	if not FileAccess.file_exists("user://settings.json"):
		return

	var settings_file = FileAccess.open("user://settings.json", FileAccess.READ)
	
	var json_string = settings_file.get_as_text()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	settings = json.data


func save_settings():
	var settings_file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	var json_string = JSON.stringify(settings, "\t")
	settings_file.store_line(json_string)
	settings_file.close()
