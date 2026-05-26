extends PanelContainer

var building

@export var category: String

var pressed_count: int = 0

@onready var building_name_label = $MarginContainer/HBoxContainer/VBoxContainer/BuildingNameLabel
@onready var description_label = $MarginContainer/HBoxContainer/VBoxContainer/DescriptionLabel
@onready var icon = $MarginContainer/HBoxContainer/TextureRect
@onready var outline_on_select = $outlineOnSelect

func _ready() -> void:
	Global.deselected.connect(hide_outline)
	Global.deselected_slot.connect(hide_outline)

func set_building(data: Dictionary):
	building_name_label.text = data["display_name"]
	icon.texture = data["icon"]
	category = data["category"]

func _on_button_pressed() -> void:
	if not outline_on_select.visible:
		get_parent().button_on_deselected()
		show_outline()

func show_outline():
	outline_on_select.visible = true

func hide_outline():
	outline_on_select.visible = false
