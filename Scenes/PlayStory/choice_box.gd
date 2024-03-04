extends VBoxContainer

signal choice_pressed

var choice_button_scene = preload("res://Scenes/PlayStory/choice_button.tscn")

@export var character_label:Node
@export var text_label:Node
@export var choices_container:Node

func _ready():
	var fade_tween = create_tween()
	character_label.set_indexed("modulate:a", 0)
	fade_tween.tween_property(character_label, "modulate:a", 1, 0.5)
	text_label.set_indexed("visible_ratio", 0)
	fade_tween.tween_property(text_label,"visible_ratio", 1, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	choices_container.set_indexed("modulate:a", 0)
	fade_tween.tween_property(choices_container, "modulate:a", 1, 0.5)
	pass # Replace with function body.

func set_character(text):
	character_label.text = text
	pass

func set_text(text):
	text_label.text = text
	pass

func set_choices(choices):
	for choice in choices:
		var new_choice_button = choice_button_scene.instantiate()
		choices_container.add_child(new_choice_button)
		new_choice_button.text = choice["choice"]
		new_choice_button.next = choice["next"]
		new_choice_button.pressed.connect(func(): choice_pressed.emit(choice))
