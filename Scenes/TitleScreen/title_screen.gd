extends Control


func _ready():
	pass # Replace with function body.



func _on_create_story_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/create_story.tscn")


func _on_exit_button_pressed():
	get_tree().quit()


func _on_play_story_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/select_story.tscn")
	pass # Replace with function body.
