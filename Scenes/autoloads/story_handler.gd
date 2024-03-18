extends Node

var current_story_data = {}

var story_cache = []

var user_inputs = []

func _ready():
	pass # Replace with function body.

func set_story_data(story_data):
	current_story_data = story_data

func store_story_cache(story_data):
	story_cache.push_back(story_data)

func store_user_input(user_input):
	user_inputs.push_back(user_input)

func clear_user_inputs():
	user_inputs = []
