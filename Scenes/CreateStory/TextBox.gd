extends GraphNode

signal request_delete

@onready var name_menu = $NameMenu
@onready var name_menu_popup = name_menu.get_popup()
@onready var dialog_input = $DialogInput

func _ready():
	add_to_group("storyboxes")
	name_menu_popup.id_pressed.connect(item_selected)


func _on_delete_button_pressed():
	request_delete.emit(self)
	pass # Replace with function body.

func update_characters_list(list):

	name_menu_popup.clear()
	for character in list:
		name_menu_popup.add_item(character["characterName"])
	
	#Updates the Name Menu text if current text is not in list.
	var found = false
	for character in list:
		if name_menu.text == character["characterName"]:
				found = true
	if found == false:
		name_menu.text = "Choose Character"

func item_selected(id):
	name_menu.text = name_menu_popup.get_item_text(id)

func get_story_box_data():
	return {
		"storyBoxName": name,
		"type": "text",
		"character": name_menu.text,
		"dialog": dialog_input.text
	}
