extends Button

var next

func _ready():
	add_to_group("choice_buttons")
	set_text_size()

func set_text_size():
	#self.theme_override_font_sizes.font_size = StoryPlayerSettings.text_size
	self.set("theme_override_font_sizes/font_size", StoryPlayerSettings.text_size)

