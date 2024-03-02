extends PanelContainer

@onready var name_label = $MarginContainer/VBoxContainer/HBoxContainer/NameLabel
@onready var description_label = $MarginContainer/VBoxContainer/DescLabel
@onready var delete_button = $MarginContainer/VBoxContainer/HBoxContainer/DeleteButton

func _ready():
	pass # Replace with function body.


func set_item_name(text):
	name_label.text = text
func set_description(text):
	description_label.text = text


func _on_delete_button_pressed():
	self.queue_free()
	pass # Replace with function body.
