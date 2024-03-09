extends PanelContainer

@export var character_name:Node
@export var dialog:Node
@export var choice:Node

func _ready():
	pass # Replace with function body.

func set_character_name(string):
	character_name.text = string

func set_dialog(string):
	dialog.text = string

func set_choice(string):
	choice.text = string
