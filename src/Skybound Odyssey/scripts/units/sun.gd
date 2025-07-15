extends Node2D

@export var a = randf_range(1, 3)
var b = randf_range(0, 2 * PI)
var c = randi() % 3

@onready var MTypeStar = $GiantStar/Sprite/M
@onready var GTypeStar = $GiantStar/Sprite/G
@onready var OTypeStar = $GiantStar/Sprite/O

func _ready() -> void:
	self.rotate(b)
	print(b)
	if c == 0:
		MTypeStar.visible = true
		GTypeStar.visible = false
		OTypeStar.visible = false
	elif c == 1:
		MTypeStar.visible = false
		GTypeStar.visible = true
		OTypeStar.visible = false
	elif c == 2:
		MTypeStar.visible = false
		GTypeStar.visible = false
		OTypeStar.visible = true
