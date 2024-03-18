extends Control

@export var lesson_line_edit:Node
@export var explanation_text_edit:Node


func _ready():
	pass # Replace with function body.

func get_lesson():
	return lesson_line_edit.text

func get_explanation():
	return explanation_text_edit.text

func load_from_save(lesson_info):
	lesson_line_edit.text = lesson_info["lesson"]
	explanation_text_edit.text = lesson_info["explanation"]
