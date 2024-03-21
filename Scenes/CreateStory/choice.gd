extends PanelContainer

signal choice_delete

@export var choice_input:Node
@export var points_input:Node

func _ready():
	pass # Replace with function body.


func get_choice_text():
	return choice_input.text
	
func get_choice_points():
	return int(points_input.text)

func set_choice_text(text):
	choice_input.text = text

func set_points_input(val):
	points_input.text = str(val)

func _on_delete_button_pressed():
	choice_delete.emit()
	#self.queue_free()


func _on_add_button_pressed():
	if points_input.text == "":
		points_input.text = str(0)
	else:
		points_input.text = str(int(points_input.text) + 1)


func _on_subtract_button_pressed():
	if points_input.text == "":
		points_input.text = str(0)
	else:
		points_input.text = str(int(points_input.text) - 1)


func _on_points_input_text_submitted(new_text):
	points_input.text = str( round(float(new_text)) )
