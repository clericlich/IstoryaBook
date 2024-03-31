extends HBoxContainer

@export var input_text:Node
@export var points_value:Node

func _ready():
	pass # Replace with function body.

func set_input_text(text):
	input_text.text = text

func set_points_value(val):
	points_value.text = str(val)
