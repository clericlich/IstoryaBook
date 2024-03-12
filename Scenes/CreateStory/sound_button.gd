extends HBoxContainer

@export var sound_button:Node
@onready var sound_menu = sound_button.get_popup()

func _ready():
	sound_menu.id_pressed.connect(resource_selected)
	pass # Replace with function body.

func get_sound_menu():
	return sound_menu

func get_sound_button():
	return sound_button

func resource_selected(id):
	sound_button.text = sound_button.get_item_text(id)

func _on_delete_button_pressed():
	self.queue_free()
