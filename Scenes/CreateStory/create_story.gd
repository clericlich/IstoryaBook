extends Control

@export var story_graph:Node
@export var characters_tab:Node
@export var title_input:Node
@export var file_dialog:Node
@export var save_dialog:Node
@export var load_dialog:Node

var story_data = {}
var save_data = {}

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


func _on_save_button_pressed():
	var story_title = title_input.text
	var story_tree = story_graph.get_story_data()
	var characters_list = characters_tab.get_all_characters()
	var positions = []

	for storybox in story_graph.get_children():
		var position = {"storyBoxName": storybox.name,"position_x": storybox.position_offset.x, "position_y": storybox.position_offset.y}
		positions.push_back(position)


	save_data = {
		"storyBoxTitle": story_title,
		"storyTree": story_tree,
		"characters": characters_list,
		"connections":story_graph.get_connection_list(),
		"positions":positions
	}

	save_dialog.show()

func _on_load_button_pressed():
	load_dialog.show()


func _on_save_dialog_file_selected(path):
	var save_file = FileAccess.open(path+".json",FileAccess.WRITE)
	var json_string = JSON.stringify(save_data)
	save_file.store_line(json_string)
	save_file.close()


func _on_load_dialog_file_selected(path):
	var save_file = FileAccess.open(path, FileAccess.READ)
	var json_string = save_file.get_as_text()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	save_data = json.get_data()
	
	title_input.text = save_data["storyBoxTitle"]
	characters_tab.load_from_save(save_data["characters"])
	story_graph.load_from_save(save_data["storyTree"], save_data["positions"], save_data["connections"])
