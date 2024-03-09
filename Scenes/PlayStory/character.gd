extends PanelContainer

@export var character_name:Node
@export var description:Node


func _ready():
	pass # Replace with function body.

func set_character_name(string):
	character_name.text = string

func set_description(string):
	description.text = string
