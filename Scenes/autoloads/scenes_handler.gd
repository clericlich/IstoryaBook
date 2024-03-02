extends Node

var switching_scene = false

func _ready():
	pass # Replace with function body.

func switch_scene(path):
	get_tree().change_scene_to_file(path)
