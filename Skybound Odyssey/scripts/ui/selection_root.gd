extends Node2D

@export var rotate_speed = 0.1

@onready var arrow_scene = $SelectArrow
@onready var camera = get_viewport().get_camera_2d()
@onready var radius: float

var arrows = []

#动画缩放
var anim_scale := 1.0

var tween: Tween

# =====生成箭头=====

func _ready():
	arrow_scene.queue_free()
	radius = get_parent().radius + 5
	Global.connect("deselected", Callable(self, "hide_arrow"))

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

		#最终scale
		scale = Vector2.ONE * (anim_scale / z)

		# 更新箭头位置
		for i in range(arrows.size()):
			var arrow = arrows[i]

			var angle = i * PI / 2
			var display_radius = radius * z

			arrow.position = Vector2(display_radius, 0).rotated(angle)


# =====动画=====

func show_arrow():
	print(1)
	if tween:
		tween.kill()

	anim_scale = 1.2
	modulate.a = 0.0
	visible = true

	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	tween.parallel().tween_property(self, "anim_scale", 1.0, 0.3)
	tween.parallel().tween_property(self, "modulate:a", 1.0, 0.3)


func hide_arrow():
	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

	tween.parallel().tween_property(self, "anim_scale", 0.7, 0.3)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.3)

	#动画结束后隐藏
	tween.tween_callback(func(): visible = false)
