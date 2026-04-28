extends NinePatchRect

@export var have_buildings: bool = false

@onready var HaveBuildingsContainer = $MarginContainer/HaveBuildingsContainer
@onready var NoBuildingsContainer = $MarginContainer/NoBuildingsContainer

func _ready() -> void:
	if have_buildings == false:
		HaveBuildingsContainer.visible = false
