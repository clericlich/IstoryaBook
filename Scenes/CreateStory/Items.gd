extends Control

var item_panel_scene = preload("res://Scenes/CreateStory/item_panel.tscn") 

@onready var item_grid = $MarginContainer/ScrollContainer/GridContainer
@onready var add_item_window = $AddItemWindow
@onready var item_name_input = $AddItemWindow/VBoxContainer/ItemNameInput
@onready var description_input = $AddItemWindow/VBoxContainer/DescriptionInput

func _ready():
	pass # Replace with function body.


func _on_add_item_button_pressed():
	add_item_window.show()


func _on_finish_button_pressed():
	add_item_window.hide()
	
	var new_item_panel = item_panel_scene.instantiate()
	item_grid.add_child(new_item_panel)
	item_grid.move_child(new_item_panel, -2)
	new_item_panel.set_item_name(item_name_input.text)
	new_item_panel.set_description(description_input.text)
	
	item_name_input.text = ""
	description_input.text = ""


func _on_hide_window_pressed():
	add_item_window.hide()
	pass # Replace with function body.
