extends Control

var text_box_scene = preload("res://Scenes/PlayStory/text_box.tscn")
var choice_box_scene = preload("res://Scenes/PlayStory/choice_box.tscn")

@export var story_title:Node
@export var text_area:Node
@export var scroll_container:Node

var story_data = StoryHandler.current_story_data
var story_tree = []
var current_story_box

func _ready():
	story_title.text = story_data["storyBoxTitle"]
	
	story_tree = story_data["storyTree"]
	for story_box in story_tree:
		if story_box["type"] == "start":
			current_story_box = story_box
			play_story_box(current_story_box)


func play_story_box(story_box):
	match story_box["type"]:
		"start":
			var new_text_box = text_box_scene.instantiate()
			new_text_box.continue_pressed.connect(func(): go_to_next_story_box(story_box))
			new_text_box.set_text("Hello. Welcome to Istorya Book")# Change after.
			new_text_box.set_character("")
			new_text_box.character_label.hide()
			text_area.add_child(new_text_box)

		"end":
			var new_text_box = text_box_scene.instantiate()
			new_text_box.continue_pressed.connect(func(): go_to_next_story_box(story_box))
			new_text_box.set_text("End.")# Change after.
			new_text_box.set_character("")
			new_text_box.character_label.hide()
			text_area.add_child(new_text_box)

		"text":
			var new_text_box = text_box_scene.instantiate()
			new_text_box.continue_pressed.connect(func(): go_to_next_story_box(story_box))
			new_text_box.set_text(story_box["dialog"])
			new_text_box.set_character(story_box["character"])
			text_area.add_child(new_text_box)

		"choice":
			var new_choice_box = choice_box_scene.instantiate()
			new_choice_box.set_text(story_box["dialog"])
			new_choice_box.set_character(story_box["character"])
			new_choice_box.set_choices(story_box["choices"])
			new_choice_box.choice_pressed.connect(func(choice): go_to_next_story_box(story_box, choice))
			text_area.add_child(new_choice_box)


func go_to_next_story_box(curr, user_input = null):
	var end_box = {
		"storyBoxName": "EndNode",
		"type": "end"
	}
	
	for box in text_area.get_children():
		var fade_tween = create_tween()
		box.set_indexed("modulate:a", 0)
		fade_tween.tween_property(box, "modulate:a", 0, 0.2)
		await fade_tween.finished
		box.queue_free()

	if curr["type"] == "end":
		ScenesHandler.switch_scene("res://Scenes/title_screen.tscn")
	if user_input != null:
		if not user_input.has("next"):
			play_story_box(end_box)
			return
	else:
		if not curr.has("next"):
			play_story_box(end_box)
			return


	match curr["type"]:
		"start":
			for story_box in story_tree:
				if story_box["storyBoxName"] == curr["next"]:
					current_story_box = story_box
					play_story_box(current_story_box)
		"text":
			for story_box in story_tree:
				if story_box["storyBoxName"] == curr["next"]:
					current_story_box = story_box
					play_story_box(current_story_box)
		"choice":
			for story_box in story_tree:
				if story_box["storyBoxName"] == user_input["next"]:
					current_story_box = story_box
					play_story_box(current_story_box)

