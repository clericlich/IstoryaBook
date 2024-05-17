extends Control

@export var story_title_input:Node
@export var resource_folder_button:Node
@export var create_button:Node
@export var file_dialog:Node

func _ready():
	pass # Replace with function body.


func _on_resource_folder_button_pressed():
	file_dialog.visible = !file_dialog.visible


func _on_file_dialog_dir_selected(dir):
	resource_folder_button.text = dir


func _on_create_button_pressed():
	InitialCreateSettings.initial_title = story_title_input.text
	InitialCreateSettings.initial_resource_folder = resource_folder_button.text
	InitialCreateSettings.from_initial_create = true
	
	ScenesHandler.switch_scene("res://Scenes/create_story.tscn")


func _on_return_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/title_screen.tscn")
	pass # Replace with function body.
