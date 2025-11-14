extends Node2D

#公转信息
@export var orbit_speed: float = 1
@export var clockwise: bool
var orbit_radius: float = 200

func set_radius(radius):
	# 设置初始位置
	if get_child_count() > 0:
		@warning_ignore("shadowed_global_identifier")
		var planet = get_child(0)
		planet.position = Vector2(radius, 0)
		rotate(randf() * 2 * PI)
		orbit_radius = radius

#绘制轨道
func _draw():
	if orbit_radius > 0.0:
		draw_circle(Vector2.ZERO, orbit_radius, Color(0.502, 0.502, 0.502, 0.502), false)

func _process(delta: float) -> void:
	var dir := 1.0 if clockwise else -1.0
	rotate(dir * orbit_speed * delta)
