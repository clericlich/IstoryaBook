extends Control

signal resource_list_changed

@export var resource_file_dialog:Node
@export var resource_folder_button:Node
@export var resource_list:Node

var resources_paths = []
var file_extensions = ["png", "mp3", "jpg", "jpeg"]


func _ready():
	if GlobalSettings.settings.has("ResourceFolder"):
		resource_folder_button.text = GlobalSettings.settings["ResourceFolder"]
		get_resources_paths()


func _on_resource_folder_button_pressed():
	resource_file_dialog.show()


func _on_resource_file_dialog_dir_selected(dir):
	resource_folder_button.text = dir
	GlobalSettings.settings["ResourceFolder"] = dir
	GlobalSettings.save_settings()

	get_resources_paths()


func get_resources_paths():
	resources_paths.clear()
	if GlobalSettings.settings.has("ResourceFolder"):
		var resource_folder_dir = DirAccess.open(GlobalSettings.settings["ResourceFolder"])
		for file in resource_folder_dir.get_files():
			if file_extensions.has(file.get_extension()):
				resources_paths.push_back(GlobalSettings.settings["ResourceFolder"]+"/"+file)
		resources_paths.sort()
	set_resources_list()
	resource_list_changed.emit()
	#print(resources_paths)


func set_resources_list():
	resource_list.clear()
	for file in resources_paths:
		resource_list.add_item(file.get_file())


func get_all_resources():
	return resources_paths


func _on_reload_button_pressed():
	get_resources_paths()
