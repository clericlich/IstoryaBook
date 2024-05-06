extends PanelContainer

@export var volume_value:Node
@export var volume_slider:Node

func _ready():
	pass # Replace with function body.


func _on_volume_slider_value_changed(value):
	volume_value.text = str(value * 100)

	var master_bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(volume_slider.value))


func _on_close_button_pressed():
	self.hide()
	pass # Replace with function body.


func _on_spin_box_value_changed(value):
	StoryPlayerSettings.text_size = value
	get_tree().call_group("storyboxes", "set_text_size")
	get_tree().call_group("choice_buttons", "set_text_size")
	pass # Replace with function body.
