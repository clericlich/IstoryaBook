extends VBoxContainer

signal keyword_entered

@export var character_label:Node
@export var text_label:Node
@export var keyword_line:Node

var keywords = []

func _ready():
	var fade_tween = create_tween()
	character_label.set_indexed("modulate:a", 0)
	fade_tween.tween_property(character_label, "modulate:a", 1, 0.5)
	text_label.set_indexed("visible_ratio", 0)
	fade_tween.tween_property(text_label,"visible_ratio", 1, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	#choices_container.set_indexed("modulate:a", 0)
	#fade_tween.tween_property(choices_container, "modulate:a", 1, 0.5)
	pass # Replace with function body.

func set_character(text):
	character_label.text = text
	pass

func set_text(text):
	text_label.text = text
	pass

func set_keywords(sent_keywords):
	keywords = sent_keywords

func _on_keyword_line_text_submitted(new_text):
	for keyword in keywords:
		if new_text == keyword["keyword"]:
			keyword_entered.emit(keyword)

func _on_enter_button_pressed():
	var new_text = keyword_line.text
	for keyword in keywords:
		if new_text == keyword["keyword"]:
			keyword_entered.emit(keyword)
