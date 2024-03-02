extends PanelContainer

signal choice_delete

@onready var choice_input = $HBoxContainer/LineEdit

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_choice_text():
	return choice_input.text

func _on_delete_button_pressed():
	choice_delete.emit()
	#self.queue_free()

