extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_yes_button_pressed():
	ScenesHandler.switch_scene("res://Scenes/title_screen.tscn")


func _on_no_button_pressed():
	self.hide()
