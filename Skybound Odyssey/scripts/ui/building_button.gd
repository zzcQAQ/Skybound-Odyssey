extends PanelContainer

var building

@onready var building_name_label = $MarginContainer/HBoxContainer/VBoxContainer/BuildingNameLabel
@onready var description_label = $MarginContainer/HBoxContainer/VBoxContainer/DescriptionLabel
@onready var icon = $MarginContainer/HBoxContainer/TextureRect


func set_building(data: Dictionary):
	building_name_label.text = data["display_name"]
	#description_label.text = data["description"]
	icon.texture = data["icon"]
