class_name BuildingCategoryButton
extends TextureButton

@onready var vSeparator = $VSeparator

func _ready() -> void:
	vSeparator.visible = true

func show_line():
	vSeparator.visible = true

func _on_pressed() -> void:
	get_parent().show_other_lines()
	vSeparator.visible = false
