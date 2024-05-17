extends Control

@export var information_panel:Node

func _ready():
	information_panel.hide()
	pass # Replace with function body.



func _on_create_story_button_pressed():
#	ScenesHandler.switch_scene("res://Scenes/create_story.tscn")
	ScenesHandler.switch_scene("res://Scenes/initial_create.tscn")

func _on_exit_button_pressed():
	get_tree().quit()


func _on_play_story_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/select_story.tscn")
	pass # Replace with function body.


func _on_settings_pressed():
	ScenesHandler.switch_scene("res://Scenes/settings.tscn")
	pass # Replace with function body.


func _on_load_story_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/load_story.tscn")
	pass # Replace with function body.


func _on_info_button_pressed():
	if information_panel.visible:
		information_panel.hide()
	else:
		information_panel.show()
