extends Control

@export var story_file_dialog:Node
@export var resource_folder_dialog:Node
@export var story_file_button:Node
@export var resource_folder_button:Node


func _ready():
	pass # Replace with function body.


func _on_story_file_button_pressed():
	story_file_dialog.visible = !story_file_dialog.visible


func _on_resource_folder_button_pressed():
	resource_folder_dialog.visible = !resource_folder_dialog.visible


func _on_story_file_dialog_file_selected(path):
	story_file_button.text = path


func _on_resource_folder_dialog_dir_selected(dir):
	resource_folder_button.text = dir


func _on_create_button_pressed():
	if story_file_button.text != "":
		InitialCreateSettings.initial_title = story_file_button.text
		InitialCreateSettings.initial_resource_folder = resource_folder_button.text
		InitialCreateSettings.from_load = true
		ScenesHandler.switch_scene("res://Scenes/create_story.tscn")


func _on_return_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/title_screen.tscn")
	pass # Replace with function body.
