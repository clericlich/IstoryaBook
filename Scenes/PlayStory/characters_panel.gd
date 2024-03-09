extends PanelContainer

var character_scene = preload("res://Scenes/PlayStory/character.tscn")

@export var characters_list:Node

func _ready():
	pass # Replace with function body.

func set_characters(characters):
	for character in characters_list.get_children():
		character.queue_free()

	for character in characters:
		var new_character = character_scene.instantiate()
		new_character.set_character_name(character["characterName"])
		new_character.set_description(character["description"])
		characters_list.add_child(new_character)


func _on_close_button_pressed():
	self.hide()
	pass # Replace with function body.
