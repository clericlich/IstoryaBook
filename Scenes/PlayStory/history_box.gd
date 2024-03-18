extends PanelContainer

@export var character_name:Node
@export var dialog:Node
@export var user_input:Node

func _ready():
	pass # Replace with function body.

func set_character_name(string):
	character_name.text = string

func set_dialog(string):
	dialog.text = string

func set_user_input(string):
	user_input.text = string

func hide_user_input():
	user_input.hide()
