extends GraphNode

signal request_delete
signal choice_delete

var choice_scene = preload("res://Scenes/CreateStory/choice.tscn")

@onready var name_menu = $NameMenu
@onready var name_menu_popup = name_menu.get_popup()
@onready var dialog_input = $DialogInput

func _ready():
	add_to_group("storyboxes")
	name_menu_popup.id_pressed.connect(item_selected)
	_on_add_choice_button_pressed()


func _on_delete_button_pressed():
	request_delete.emit(self)
	pass # Replace with function body.

func update_characters_list(list):
	name_menu_popup.clear()
	for character in list:
		name_menu_popup.add_item(character["characterName"])
	pass

func item_selected(id):
	name_menu.text = name_menu_popup.get_item_text(id)


func _on_add_choice_button_pressed():
	var new_choice = choice_scene.instantiate()
	
	self.add_child(new_choice)
	self.set_slot_enabled_right(new_choice.get_index(), true)
	new_choice.choice_delete.connect(func(): choice_delete.emit(self, new_choice, new_choice.get_index() - 5))

func get_story_box_data():
	var choices = []

	for child in get_children():
		if child.has_method("get_choice_text"):
			choices.push_back( {"choice":child.get_choice_text(), "port":child.get_index() - 5} )

	return {
		"storyBoxName": name,
		"type": "choice",
		"character": name_menu.text,
		"dialog": dialog_input.text,
		"choices": choices
	}
