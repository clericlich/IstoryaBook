extends GraphNode

signal request_delete
signal keyword_delete

@export var background_menu_button:Node
@export var sound_menu_button1:Node
@export var sound_menu_button2:Node

var keyword_scene = preload("res://Scenes/CreateStory/keyword.tscn")

@onready var background_menu_popup = background_menu_button.get_popup()
@onready var sound_menu_popup1 = sound_menu_button1.get_popup()
@onready var sound_menu_popup2 = sound_menu_button2.get_popup()
@onready var name_menu = $NameMenu
@onready var name_menu_popup = name_menu.get_popup()
@onready var dialog_input = $DialogInput

var image_extensions = ["png", "jpg", "jpeg"]
var sound_extensions = ["mp3"]

func _ready():
	add_to_group("storyboxes")
	name_menu_popup.id_pressed.connect(character_selected)
	background_menu_popup.id_pressed.connect(image_resource_selected)
	sound_menu_popup1.id_pressed.connect(sound_resource1_selected)
	sound_menu_popup2.id_pressed.connect(sound_resource2_selected)

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

func update_resources_list(list):
	#Background Menu
	background_menu_popup.clear()
	background_menu_popup.add_item("None")
	for resource in list:
		if image_extensions.has(resource.get_extension()):
			background_menu_popup.add_item(resource.get_file())

	var found = false
	for resource in list:
		if background_menu_button.text == resource.get_file():
			found = true
	if found == false:
		background_menu_button.text = "None"

	#Sound Menus
	sound_menu_popup1.clear()
	sound_menu_popup2.clear()
	sound_menu_popup1.add_item("None")
	sound_menu_popup2.add_item("None")
	for resource in list:
		if sound_extensions.has(resource.get_extension()):
			sound_menu_popup1.add_item(resource.get_file())
			sound_menu_popup2.add_item(resource.get_file())

	found = false
	for resource in list:
		if sound_menu_button1.text == resource.get_file():
			found = true
	if found == false:
		sound_menu_button1.text = "None"

	found = false
	for resource in list:
		if sound_menu_button2.text == resource.get_file():
			found = true
	if found == false:
		sound_menu_button2.text = "None"


func character_selected(id):
	name_menu.text = name_menu_popup.get_item_text(id)

func image_resource_selected(id):
	background_menu_button.text = background_menu_popup.get_item_text(id)

func sound_resource1_selected(id):
	sound_menu_button1.text = sound_menu_popup1.get_item_text(id)

func sound_resource2_selected(id):
	sound_menu_button2.text = sound_menu_popup2.get_item_text(id)

func _on_add_keyword_button_pressed():
	var new_keyword = keyword_scene.instantiate()
	
	self.add_child(new_keyword)
	self.set_slot_enabled_right(new_keyword.get_index(), true)
	new_keyword.keyword_delete.connect(func(): keyword_delete.emit(self, new_keyword, new_keyword.get_index() - 7))

func get_story_box_data():
	var keywords = []

	for child in get_children():
		if child.has_method("get_keyword_text"):
			if str(child.get_keyword_points()) == "":
				keywords.push_back( {"keyword":child.get_keyword_text(),"points": 0 ,"port":child.get_index() - 7} )
			else:
				keywords.push_back( {"keyword":child.get_keyword_text(),"points": child.get_keyword_points() ,"port":child.get_index() - 7} )

	return {
			"storyBoxName": name,
			"type": "keyword",
			"character": name_menu.text,
			"dialog": dialog_input.text,
			"background": background_menu_button.text,
			"sound1": sound_menu_button1.text,
			"sound2": sound_menu_button2.text,
			"keywords": keywords
	}

func load_from_save(story_data):
	self.name = story_data["storyBoxName"]
	name_menu.text = story_data["character"]
	dialog_input.text = story_data["dialog"]
	background_menu_button.text = story_data["background"]
	sound_menu_button1.text = story_data["sound1"]
	sound_menu_button2.text = story_data["sound2"]

	for keyword in story_data["keywords"]:
		var new_keyword = keyword_scene.instantiate()
		self.add_child(new_keyword)
		self.set_slot_enabled_right(new_keyword.get_index(), true)
		new_keyword.keyword_delete.connect(func(): keyword_delete.emit(self, new_keyword, new_keyword.get_index() - 7))
		new_keyword.set_keyword_text(keyword["keyword"])
		new_keyword.set_points_input(keyword["points"])
