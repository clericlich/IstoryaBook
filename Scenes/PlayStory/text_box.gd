extends VBoxContainer

signal continue_pressed

@export var character_label:Node
@export var text_label:Node
@export var continue_button:Node

func _ready():
	add_to_group("storyboxes")
	set_text_size()
	
	var fade_tween = create_tween()
	character_label.set_indexed("modulate:a", 0)
	fade_tween.tween_property(character_label, "modulate:a", 1, 0.5)
	text_label.set_indexed("visible_ratio", 0)
	fade_tween.tween_property(text_label,"visible_ratio", 1, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	continue_button.set_indexed("modulate:a", 0)
	fade_tween.tween_property(continue_button, "modulate:a", 1, 0.5)

func set_text(text):
	text_label.text = text

func set_text_size():
	text_label.label_settings.font_size = StoryPlayerSettings.text_size
	character_label.label_settings.font_size = StoryPlayerSettings.text_size + 30

func set_character(text):
	character_label.text = text

func _on_continue_button_pressed():
	continue_pressed.emit()
	continue_button.hide()

