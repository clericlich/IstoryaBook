extends VBoxContainer

signal continue_pressed

@export var character_label:Node
@export var text_label:Node
@export var continue_button:Node

func _ready():
	var fade_tween = create_tween()
	character_label.set_indexed("modulate:a", 0)
	fade_tween.tween_property(character_label, "modulate:a", 1, 0.5)
	text_label.set_indexed("visible_ratio", 0)
	fade_tween.tween_property(text_label,"visible_ratio", 1, 3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)

func set_text(text):
	text_label.text = text

func set_character(text):
	character_label.text = text

func _on_continue_button_pressed():
	continue_pressed.emit()
	continue_button.hide()

