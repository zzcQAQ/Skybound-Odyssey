class_name GiantStar extends celestialBody

#恒星属性
@export var size: float = 1
@export var luminosity = 0.01

#加载贴图
var MType = preload("res://sprites/units/star/MType.png")
var GType = preload("res://sprites/units/star/GType.png")
var OType = preload("res://sprites/units/star/OType.png")
@onready var sprite = $Sprite2D

#自转
@export var rotateSpeed = Seed.rotateSpeed * 0.1

func _process(delta):
	super._process(delta)
	self.rotate(0.1 * delta)
	
#初始化
func _ready():
	lerp_scale = Vector2(0.9, 0.9)
	rng.seed = hash(get_parent().name)
	luminosity = rng.randf_range(0.5, 3.0)
	luminosity = snapped(luminosity, 0.01)
	sprite.texture = MType
	#if luminosity >= 0 and luminosity < 1:
		#sprite.texture = MType
	#elif luminosity >= 1 and luminosity < 2:
		#sprite.texture = GType
	#elif luminosity >= 2 and luminosity <= 3:
		#sprite.texture = OType
