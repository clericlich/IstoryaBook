extends GraphEdit

@export var characters_tab:Node
@export var resources_tab:Node

var text_box_scene = preload("res://Scenes/CreateStory/text_box.tscn")
var choice_box_scene = preload("res://Scenes/CreateStory/choice_box.tscn")

var characters_list = []
var resources_list = []

func _ready():
	characters_tab.character_list_changed.connect(character_list_updates)
	resources_tab.resource_list_changed.connect(resource_list_updates)
	pass # Replace with function body.


func _on_add_text_box_button_pressed():
	var new_text_box = text_box_scene.instantiate()
	new_text_box.position_offset.x = (scroll_offset.x + 170) / self.zoom
	new_text_box.position_offset.y = (scroll_offset.y + 70) / self.zoom

	self.add_child(new_text_box, true)
	new_text_box.request_delete.connect(delete_node)
	new_text_box.update_characters_list(characters_list)
	new_text_box.update_resources_list(resources_list)

func _on_add_choice_box_button_pressed():
	var new_choice_box = choice_box_scene.instantiate()
	new_choice_box.position_offset.x = (scroll_offset.x + 170) / self.zoom
	new_choice_box.position_offset.y = (scroll_offset.y + 100) / self.zoom
	
	self.add_child(new_choice_box, true)
	new_choice_box.request_delete.connect(delete_node)
	new_choice_box.choice_delete.connect(choice_delete)
	new_choice_box.update_characters_list(characters_list)
	new_choice_box.update_resources_list(resources_list)


func _on_connection_request(from_node, from_port, to_node, to_port):
	#Connects to only one port. Disconnects other ports when new connect
	var connection_list = self.get_connection_list()
	for connection in connection_list:
		if connection["from_node"] == from_node and connection["from_port"] == from_port:
			disconnect_node(from_node, from_port, connection["to_node"], connection["to_port"])
	self.connect_node(from_node, from_port, to_node, to_port)


func _on_connection_to_empty(from_node, from_port, release_position):
	var connection_list = self.get_connection_list()
	for connection in connection_list:
		if connection["from_node"] == from_node and connection["from_port"] == from_port:
			disconnect_node(from_node, from_port, connection["to_node"], connection["to_port"])

func choice_delete(node, choice, slot):
	var connection_list = self.get_connection_list()
	for connection in connection_list:
		if connection["from_node"] == node.name and connection["from_port"] == slot:
			disconnect_node(connection["from_node"], connection["from_port"], connection["to_node"], connection["to_port"])
	for connection in connection_list:
		if connection["from_node"] == node.name and connection["from_port"] > slot:
			disconnect_node(connection["from_node"], connection["from_port"], connection["to_node"], connection["to_port"])
	for connection in connection_list:
		if connection["from_node"] == node.name and connection["from_port"] > slot:
			connect_node(connection["from_node"], connection["from_port"] - 1, connection["to_node"], connection["to_port"])

	choice.queue_free()

func delete_node(node):
	var connection_list = self.get_connection_list()
	for connection in connection_list:
		if connection["from_node"] == node.name or connection["to_node"] == node.name:
			disconnect_node(connection["from_node"], connection["from_port"], connection["to_node"], connection["to_port"])
	node.queue_free()
	pass

func character_list_updates():
	characters_list = characters_tab.get_all_characters()

	if ScenesHandler.switching_scene == false:
		for storybox in get_tree().get_nodes_in_group("storyboxes"):
			storybox.update_characters_list(characters_list)

func resource_list_updates():
	resources_list = resources_tab.get_all_resources()
	
	if ScenesHandler.switching_scene == false:
		for storybox in get_tree().get_nodes_in_group("storyboxes"):
			storybox.update_resources_list(resources_list)


func get_story_data():
	var connection_list = self.get_connection_list()
	var story_box_list = self.get_children()
	var story_tree = []

	for story_box in story_box_list:
		if story_box.name == "StartNode":

			for connection in connection_list:
				if connection["from_node"] == "StartNode":
					story_tree.push_back({
						"storyBoxName": "StartNode",
						"next": connection["to_node"],
						"type": "start"
					})
					break
			continue

		var story_box_data = story_box.get_story_box_data()
		var filtered_list = find_in_connection_list(connection_list, story_box.name)
		var can_add = is_story_box_connected(connection_list, story_box.name)

		if story_box_data["type"] == "text":
			if filtered_list:
				story_box_data["next"] = filtered_list[0]["to_node"]


		if story_box_data["type"] == "choice":
			for choice in story_box_data["choices"]:
				for connection in filtered_list:
					if choice["port"] == connection["from_port"]:
						choice["next"] = connection["to_node"]


		if can_add:
			story_tree.push_back(story_box_data)
	return story_tree


func is_story_box_connected(list, node_name):
	for connection in list:
		if connection["to_node"] == node_name:
			return true
	return false

func find_in_connection_list(list, node_name):
	var filtered_list = []
	for connection in list:
		if connection["from_node"] == node_name:
			filtered_list.push_back(connection)

	return filtered_list

func load_from_save(story_tree, positions, connections):
	self.clear_connections()
	for child in self.get_children():
		if child.name != "StartNode":
			self.remove_child(child)
			child.queue_free()

	for story_box in story_tree:
		if story_box["storyBoxName"] == "StartNode":
			continue
		match story_box["type"]:
			"text":
				var new_text_box = text_box_scene.instantiate()
				self.add_child(new_text_box, true)
				new_text_box.request_delete.connect(delete_node)
				new_text_box.update_characters_list(characters_list)
				new_text_box.update_resources_list(resources_list)
				new_text_box.load_from_save(story_box)
			"choice":
				var new_choice_box = choice_box_scene.instantiate()
				self.add_child(new_choice_box, true)
				new_choice_box.request_delete.connect(delete_node)
				new_choice_box.choice_delete.connect(choice_delete)
				new_choice_box.update_characters_list(characters_list)
				new_choice_box.update_resources_list(resources_list)
				new_choice_box.load_from_save(story_box)

	for children in self.get_children():
		print(children)

	print("")
	for story_box_position in positions:
		var story_box = self.get_node(story_box_position["storyBoxName"])
		story_box.position_offset.x = story_box_position["position_x"]
		story_box.position_offset.y = story_box_position["position_y"]
		print(story_box)
		print(story_box.position_offset.x)
		print(story_box.position_offset.y)
		print("---")

	for connection in connections:
		connect_node(connection["from_node"],connection["from_port"],connection["to_node"],connection["to_port"])
