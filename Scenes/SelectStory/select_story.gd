extends Control

@export var file_dialog:Node
@export var story_folder_file_dialog:Node
@export var story_folder_button:Node
@export var story_tab_container:Node
@export var story_box_button:Node

var story_tab_scene = preload("res://Scenes/SelectStory/story_tab.tscn")

func _ready():
	for story_tab_content in StoryHandler.story_cache:
		var story_tab = story_tab_scene.instantiate()
		story_tab_container.add_child(story_tab)
		story_tab_container.move_child(story_tab, -2)

		story_tab.set_story_data(story_tab_content)
		story_tab.set_story_title(story_tab_content["storyBoxTitle"])

	clear_files()
	load_settings()
	load_files()

func _on_return_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/title_screen.tscn")


func _on_add_story_button_pressed():
	file_dialog.show()


func _on_file_dialog_file_selected(path, loaded = false):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(content)
	var parse_content
	if error == OK:
		parse_content = json.data

	if parse_content.has("storyBoxTitle"):
		if loaded == false:
			StoryHandler.store_story_cache(parse_content)

		var story_tab = story_tab_scene.instantiate()
		story_tab_container.add_child(story_tab)
		story_tab_container.move_child(story_tab, -2)

		if loaded == true:
			story_tab.add_to_group("loaded_story_tabs")
		story_tab.set_story_data(parse_content)
		story_tab.set_story_title(parse_content["storyBoxTitle"])


func _on_story_folder_button_pressed():
	story_folder_file_dialog.show()

func _on_story_folder_file_dialog_dir_selected(dir):
	story_folder_button.text = dir
	GlobalSettings.settings["StoryFolder"] = dir
	
	clear_files()
	load_files()


func clear_files():
	for node in get_tree().get_nodes_in_group("loaded_story_tabs"):
		node.queue_free()


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

func load_files():
	if GlobalSettings.settings.has("StoryFolder"):
		var story_folder_dir = DirAccess.open(GlobalSettings.settings["StoryFolder"])
		print(story_folder_dir)
		for file in story_folder_dir.get_files():
			if file.get_extension() == "json":
				_on_file_dialog_file_selected(GlobalSettings.settings["StoryFolder"]+"/"+file, true)

func _on_tree_exiting():
	save_settings()
