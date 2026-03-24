extends Node2D

@export var rotate_speed = 0.1

@onready var arrow_scene = $SelectArrow
@onready var camera = get_viewport().get_camera_2d()
@onready var radius = get_parent().radius + 5

var arrows = []

func _ready():
	
	arrow_scene.queue_free()

	# 创建4个箭头
	for i in range(4):
		var arrow = arrow_scene.duplicate()
		add_child(arrow)
		arrows.append(arrow)

		var angle = i * PI / 2

		arrow.position = Vector2(radius, 0).rotated(angle)
		arrow.rotation = angle


func update_radius(r):
	radius = r + 10


func _process(delta):
	rotation += rotate_speed * delta

	if camera:
		var z = camera.zoom.x

		# 保持大小不变
		scale = Vector2.ONE / z

		# 更新箭头位置
		for i in range(arrows.size()):
			var arrow = arrows[i]

			var angle = i * PI / 2
			var display_radius = radius * z

			arrow.position = Vector2(display_radius, 0).rotated(angle)
