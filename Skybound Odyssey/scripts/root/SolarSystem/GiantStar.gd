class_name GiantStar 
extends CelestialBody 

#恒星属性
@export var size: float
@export var radius: float
@export var luminosity: float

@export var rotateSpeed = 0.1

#加载贴图
var MType = preload("res://accests/sprites/units/star/MType.png")
var GType = preload("res://accests/sprites/units/star/GType.png")
var OType = preload("res://accests/sprites/units/star/OType.png")
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func send_selected_signal():
	Global.emit_signal("giant_star_selected", self)

#接收恒星初始化
func star_setup(s, l):
	#半径
	size = s
	radius = 64 * s
	selection_root.update_radius(radius)
	
	#光度
	luminosity = l
	
	#贴图匹配
	sprite.scale = Vector2(s, s)
	collision.scale = Vector2(s, s)
	
	if l <= 1:
		sprite.texture = MType
	elif l <= 2:
		sprite.texture = GType
	else: sprite.texture = OType

func _process(delta):
	#super._process(delta)
	sprite.rotate(rotateSpeed * delta)
