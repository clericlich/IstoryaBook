extends Control

@export var story_graph:Node
@export var characters_tab:Node
@export var title_input:Node
@export var file_dialog:Node

var story_data = {}

@onready var return_warning = $ReturnWarning
@onready var yes_button = $ReturnWarning/VBoxContainer/HBoxContainer/YesButton
@onready var no_button = $ReturnWarning/VBoxContainer/HBoxContainer/NoButton

func _ready():
	ScenesHandler.switching_scene = false
	pass # Replace with function body.


func _on_finish_button_pressed():
	var story_title = title_input.text
	var story_tree = story_graph.get_story_data()
	var characters_list = characters_tab.get_all_characters()

	story_data = {
		"storyBoxTitle": story_title,
		"storyTree": story_tree,
		"characters": characters_list
	}

	file_dialog.show()


func _on_file_dialog_file_selected(path):
	var save_story = FileAccess.open(path + ".json", FileAccess.WRITE)
	var json_string = JSON.stringify(story_data)
	save_story.store_line(json_string)
	ScenesHandler.switching_scene = true
	ScenesHandler.switch_scene("res://Scenes/title_screen.tscn")


func _on_return_button_pressed():
	return_warning.show()

	ScenesHandler.switching_scene = true
	yes_button.pressed.connect(func():ScenesHandler.switch_scene("res://Scenes/title_screen.tscn"))
	no_button.pressed.connect(func():return_warning.hide())
