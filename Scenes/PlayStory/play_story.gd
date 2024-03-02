extends Control

var text_box_scene = preload("res://Scenes/PlayStory/text_box.tscn")

@export var story_title:Node
@export var text_area:Node
@export var scroll_container:Node

var story_data = StoryHandler.current_story_data
var story_tree = []
var current_story_box

func _ready():
	story_tree = story_data["storyTree"]
	for story_box in story_tree:
		if story_box["type"] == "start":
			current_story_box = story_box
			play_story_box(current_story_box)


func play_story_box(story_box):
	match story_box["type"]:
		"start":
			var new_text_box = text_box_scene.instantiate()
			new_text_box.continue_pressed.connect(func():go_to_next_story_box(story_box))
			new_text_box.set_text("Hello. Welcome to Istorya Book")# Change after.
			new_text_box.set_character("")
			new_text_box.character_label.hide()
			text_area.add_child(new_text_box)

		"text":
			var new_text_box = text_box_scene.instantiate()
			new_text_box.continue_pressed.connect(func():go_to_next_story_box(story_box))
			new_text_box.set_text(story_box["dialog"])
			new_text_box.set_character(story_box["character"])
			text_area.add_child(new_text_box)

		"choice":
			pass


func go_to_next_story_box(curr):
	for box in text_area.get_children():
		var fade_tween = create_tween()
		box.set_indexed("modulate:a", 0)
		fade_tween.tween_property(box, "modulate:a", 0, 0.2)
		await fade_tween.finished
		box.queue_free()

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
			pass
