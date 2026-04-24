class_name CelestialBody
extends Node2D

#加载贴图
@onready var CollisionShape = $CollisionShape2D
@onready var show_UI = false
@export var lerp_scale = Vector2(0.9, 0.9)

@onready var selection_root = $SelectionRoot

func _ready():
	selection_root.visible = false

func on_selected():
	selection_root.show_arrow()
