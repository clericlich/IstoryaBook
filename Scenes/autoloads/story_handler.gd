extends Node

var current_story_data = {"characters":[{"characterName":"Ree","description":"asdf"},{"characterName":"Koby","description":"zxcv"}],
"storyBoxTitle":"KobyTest",
"storyTree":[{"next":"ChoiceBox","storyBoxName":"StartNode", "type": "start"},
{"character":"Ree","choices":[{"choice":"Runs","next":"TextBox","port":0},{"choice":"Pets","next":"@GraphNode@165","port":1}],"dialog":"qqqqqqq","storyBoxName":"ChoiceBox","type":"choice"},
{"character":"Koby","dialog":"runs too","storyBoxName":"TextBox","type":"text"},
{"character":"Koby","dialog":"friendly","storyBoxName":"@GraphNode@165","type":"text"}]}

var story_cache = []

func _ready():
	pass # Replace with function body.

func set_story_data(story_data):
	current_story_data = story_data

func store_story_cache(story_data):
	story_cache.push_back(story_data)
