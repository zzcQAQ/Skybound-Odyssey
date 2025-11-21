class_name GiantStar extends celestialBody

#恒星属性
@export var size: float = 1
@export var rotateSpeed = 0.1
@export var luminosity:float = 1

#加载贴图
var MType = preload("res://sprites/units/star/MType.png")
var GType = preload("res://sprites/units/star/GType.png")
var OType = preload("res://sprites/units/star/OType.png")
@onready var sprite = $Sprite2D

#接收恒星初始化
func star_setup(s, l):
	size = s
	luminosity = l
	scale = Vector2(s, s)
	if l <= 1:
		sprite.texture = MType
	elif l <= 2:
		sprite.texture = GType
	else: sprite.texture = OType

func _process(delta):
	super._process(delta)
	self.rotate(rotateSpeed * delta)
