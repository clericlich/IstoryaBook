extends Control

@export var lesson_label:Node
@export var explanation_label:Node
@export var user_inputs:Node
@export var final_score:Node

@onready var user_input = preload("res://Scenes/Synthesis/user_input.tscn")

var story_data = StoryHandler.current_story_data
var inputs = StoryHandler.user_inputs
var value = 0

func _ready():
	lesson_label.text = "    " + story_data["lessonInfo"]["lesson"]
	explanation_label.text = "    " + story_data["lessonInfo"]["explanation"]
	
	for input in inputs:
		var new_user_input = user_input.instantiate()
		if input.has("choice"):
			new_user_input.set_input_text(input["choice"])
		if input.has("keyword"):
			new_user_input.set_input_text(input["keyword"])
		new_user_input.set_points_value(input["points"])
		value = value + input["points"]
		
		user_inputs.add_child(new_user_input)
	
	final_score.text = str(value)


func _on_done_button_pressed():
	StoryHandler.current_story_data = {}
	StoryHandler.user_inputs = []
	ScenesHandler.switch_scene("res://Scenes/title_screen.tscn")
	pass # Replace with function body.
