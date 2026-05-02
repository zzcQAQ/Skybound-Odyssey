class_name CelestialBody
extends Node2D

#加载贴图
@onready var CollisionShape = $CollisionShape2D
@onready var show_UI = false
@export var lerp_scale = Vector2(0.9, 0.9)

@onready var selection_root = $SelectionRoot

func _ready():
	selection_root.visible = false

#更新UI
func on_selected():
	
	var node_name = get_script().get_global_name()
	
	selection_root.show_arrow()
	
	if node_name == "GiantStar":
		Global.emit_signal("giant_star_selected", self)
	elif node_name == "PlanetType":
		Global.emit_signal("planet_selected", self)

func on_deselected():
	
	selection_root.hide_arrow()
	Global.deselected.emit()
