extends Control

signal character_list_changed

var character_panel_scene = preload("res://Scenes/CreateStory/character_panel.tscn")

@onready var character_grid = $MarginContainer/ScrollContainer/GridContainer
@onready var add_character_window = $AddCharacterWindow
@onready var character_name_input = $AddCharacterWindow/VBoxContainer/CharacterNameInput
@onready var description_input = $AddCharacterWindow/VBoxContainer/DescriptionInput


func _ready():
	pass # Replace with function body.


func _on_add_character_button_pressed():
	add_character_window.show()


func _on_finish_button_pressed():
	add_character_window.hide()

	var new_character_panel = character_panel_scene.instantiate()
	character_grid.add_child(new_character_panel)
	character_grid.move_child(new_character_panel, -2)
	new_character_panel.set_character_name(character_name_input.text)
	new_character_panel.set_description(description_input.text)
	new_character_panel.tree_exited.connect( func():character_list_changed.emit() )
	character_list_changed.emit()

	character_name_input.text = ""
	description_input.text = ""


func _on_hide_window_pressed():
	add_character_window.hide()

func get_all_characters():
	var all_character_data = []
	if ScenesHandler.switching_scene == false:
		#print(ScenesHandler.switching_scene)
		for character in get_tree().get_nodes_in_group("characters"):
			all_character_data.push_back(character.get_character_data())

	return all_character_data

func load_from_save(characters):
	for child in character_grid.get_children():
		if child.name != "AddCharacterButton":
			child.queue_free()
	
	for character in characters:
		var new_character_panel = character_panel_scene.instantiate()
		character_grid.add_child(new_character_panel)
		character_grid.move_child(new_character_panel, -2)
		new_character_panel.set_character_name(character["characterName"])
		new_character_panel.set_description(character["description"])
		new_character_panel.tree_exited.connect( func():character_list_changed.emit() )

	character_list_changed.emit()
