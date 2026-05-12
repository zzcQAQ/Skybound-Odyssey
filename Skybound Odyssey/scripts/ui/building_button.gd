extends PanelContainer

var building

@onready var building_name = $MarginContainer/HBoxContainer/VBoxContainer/Label
@onready var icon = $MarginContainer/HBoxContainer/TextureRect


func set_building(b):

	building = b

	building_name.text = b.display_name
	icon.texture = b.icon
