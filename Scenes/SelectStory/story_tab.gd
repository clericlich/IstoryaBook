extends PanelContainer

@export var story_title_label:Node
@export var delete_button:Node

var story_data

func _ready():
	pass # Replace with function body.

func set_story_data(data):
	story_data = data

func set_story_title(title):
	story_title_label.text = title


func _on_delete_button_pressed():
	self.queue_free()
	pass # Replace with function body.


func _on_play_story_button_pressed():
	StoryHandler.set_story_data(story_data)
	ScenesHandler.switch_scene("res://Scenes/play_story.tscn")

func hide_delete_button():
	delete_button.hide()
