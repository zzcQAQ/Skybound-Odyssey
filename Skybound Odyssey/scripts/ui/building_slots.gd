extends VBoxContainer

@export var current_slot: int = 0

@onready var surface_building_label = $HBoxContainer/surfaceBuildingLabel
@onready var orbital_building_label = $HBoxContainer/orbitalBuildingLabel

@onready var surface_slots = $surfaceSlots
@onready var orbital_slots = $orbitalSlots

@onready var left_button = $HBoxContainer/leftButton
@onready var right_button = $HBoxContainer/rightButton

func _ready() -> void:
	show_surface_buildings()

func _on_left_button_pressed() -> void:
	show_surface_buildings()

func _on_right_button_pressed() -> void:
	show_orbital_buildings()

func show_surface_buildings():
	orbital_building_label.visible = false
	orbital_slots.visible = false
	surface_building_label.visible = true
	surface_slots.visible = true
	left_button.disabled = true
	left_button.modulate.a = 0.5
	right_button.disabled = false
	right_button.modulate.a = 1.0

func show_orbital_buildings():
	surface_building_label.visible = false
	surface_slots.visible = false
	orbital_building_label.visible = true
	orbital_slots.visible = true
	right_button.disabled = true
	right_button.modulate.a = 0.5
	left_button.disabled = false
	left_button.modulate.a = 1.0
