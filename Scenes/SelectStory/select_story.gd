extends Control

@export var file_dialog:Node
@export var story_tab_container:Node

var story_tab_scene = preload("res://Scenes/SelectStory/story_tab.tscn")

func _ready():
	for story_tab_content in StoryHandler.story_cache:
		var story_tab = story_tab_scene.instantiate()
		story_tab_container.add_child(story_tab)
		story_tab_container.move_child(story_tab, -2)

		story_tab.set_story_data(story_tab_content)
		story_tab.set_story_title(story_tab_content["storyBoxTitle"])


func _on_return_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/title_screen.tscn")


func _on_add_story_button_pressed():
	file_dialog.show()


func _on_file_dialog_file_selected(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(content)
	var parse_content
	if error == OK:
		parse_content = json.data

	if parse_content.has("storyBoxTitle"):
		StoryHandler.store_story_cache(parse_content)

		var story_tab = story_tab_scene.instantiate()
		story_tab_container.add_child(story_tab)
		story_tab_container.move_child(story_tab, -2)
		
		story_tab.set_story_data(parse_content)
		story_tab.set_story_title(parse_content["storyBoxTitle"])
