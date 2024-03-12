extends Control

@export var story_folder_file_dialog:Node
@export var story_folder_button:Node

func _ready():
	load_settings()
	pass # Replace with function body.


func _on_open_story_folder_file_dialog_button_pressed():
	story_folder_file_dialog.show()


func _on_story_folder_file_dialog_dir_selected(dir):
	story_folder_button.text = dir
	GlobalSettings.settings["StoryFolder"] = dir


func save_settings():
	var settings = GlobalSettings.settings
	var settings_file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	var json_string = JSON.stringify(settings, "\t")
	settings_file.store_line(json_string)


func load_settings():
	if not FileAccess.file_exists("user://settings.json"):
		return

	var settings_file = FileAccess.open("user://settings.json", FileAccess.READ)
	var json_string = settings_file.get_as_text()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	var settings_data = json.data
	set_saved_settings(settings_data)


func set_saved_settings(settings_data):
	if settings_data.has("StoryFolder"):
		story_folder_button.text = settings_data["StoryFolder"]


func _on_tree_exiting():
	save_settings()
func _on_return_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/title_screen.tscn")
	pass # Replace with function body.
func _on_finish_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/title_screen.tscn")
	pass # Replace with function body.
