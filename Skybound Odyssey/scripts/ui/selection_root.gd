extends Node2D

@export var radius = 1
@export var rotate_speed = 0.1

@onready var arrow_scene = $SelectArrow

func _ready():
	
	radius = get_parent().radius + 5
	
	arrow_scene.visible = false

	for i in range(4):
		var arrow = arrow_scene.duplicate()
		arrow.visible = true
		add_child(arrow)

		var angle = i * PI / 2

		arrow.position = Vector2(radius, 0).rotated(angle)

		arrow.rotation = angle  # 指向中心



func _process(delta):
	
	rotation += rotate_speed * delta
