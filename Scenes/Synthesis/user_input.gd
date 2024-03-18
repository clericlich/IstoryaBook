extends HBoxContainer

@export var choice_text:Node
@export var points_value:Node

func _ready():
	pass # Replace with function body.

func set_choice_text(text):
	choice_text.text = text

func set_points_value(val):
	points_value.text = str(val)
