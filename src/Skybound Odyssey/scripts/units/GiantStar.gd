class_name GiantStar extends celestialBody

@export var size = Seed.size
@export var luminosity = Seed.luminosity
@export var rotateSpeed = Seed.rotateSpeed

var MType = preload("res://sprites/units/star/MType.png")
var GType = preload("res://sprites/units/star/GType.png")
var OType = preload("res://sprites/units/star/OType.png")
@onready var sprite = $Sprite2D

func _ready() -> void:
	if luminosity >= 0 and luminosity < 1:
		sprite.texture = MType
	elif luminosity >= 1 and luminosity < 2:
		sprite.texture = GType
	elif luminosity >= 2 and luminosity <= 3:
		sprite.texture = OType
