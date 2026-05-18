extends PanelContainer

var building

@export var category: String

@onready var building_name_label = $MarginContainer/HBoxContainer/VBoxContainer/BuildingNameLabel
@onready var description_label = $MarginContainer/HBoxContainer/VBoxContainer/DescriptionLabel
@onready var icon = $MarginContainer/HBoxContainer/TextureRect

func set_building(data: Dictionary):
	building_name_label.text = data["display_name"]
	icon.texture = data["icon"]
	category = data["category"]
