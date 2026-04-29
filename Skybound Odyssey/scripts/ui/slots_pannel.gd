extends NinePatchRect

@export var have_buildings: bool = false

@onready var HaveBuildingsContainer = $MarginContainer/HaveBuildingsContainer
@onready var NoBuildingsContainer = $MarginContainer/NoBuildingsContainer
@onready var BuildingPicker = $BuildingPicker

func _ready() -> void:
	
	BuildingPicker.visible = false
	Global.deselected.connect(_on_deselected)
	
	if have_buildings == false:
		HaveBuildingsContainer.visible = false

func _on_pressed() -> void:
	BuildingPicker.visible = true

func _on_deselected():
	BuildingPicker.visible = false
