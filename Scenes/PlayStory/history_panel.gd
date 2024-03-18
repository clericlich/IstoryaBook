extends PanelContainer

@export var history_list:Node

var history_box_scene = preload("res://Scenes/PlayStory/history_box.tscn")

func _ready():
	pass # Replace with function body.


func add_story_box(story_box, user_input = null):
	var new_history_box = history_box_scene.instantiate()

	if (story_box["type"] != "start") and (story_box["type"] != "end"):
		new_history_box.set_character_name(story_box["character"])
		new_history_box.set_dialog(story_box["dialog"])

		if story_box["type"] == "text":
			new_history_box.hide_user_input()

		if user_input != null and story_box["type"] == "choice":
			new_history_box.set_user_input(user_input["choice"])

		history_list.add_child(new_history_box)


func _on_close_button_pressed():
	self.hide()
