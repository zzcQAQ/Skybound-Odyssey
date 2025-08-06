class_name GiantStar extends celestialBody

@export var size = Seed.size
@export var luminosity = 0.01
@export var rotateSpeed = Seed.rotateSpeed

var MType = preload("res://sprites/units/star/MType.png")
var GType = preload("res://sprites/units/star/GType.png")
var OType = preload("res://sprites/units/star/OType.png")
@onready var sprite = $Sprite2D

func _ready():
	rng.seed = hash(get_parent().name)
	luminosity = rng.randf_range(0.5, 3.0)
	luminosity = snapped(luminosity, 0.01)
	if luminosity >= 0 and luminosity < 1:
		sprite.texture = MType
	elif luminosity >= 1 and luminosity < 2:
		sprite.texture = GType
	elif luminosity >= 2 and luminosity <= 3:
		sprite.texture = OType
