extends Node2D

#公转信息
@export var orbit_speed: float = 0.05
@export var clockwise: bool = true

func set_radius(radius):
	# 设置初始位置
	if get_child_count() > 0:
		print(1)
		@warning_ignore("shadowed_global_identifier")
		var planet = get_child(0)
		planet.position = Vector2(radius, 0)

func _process(delta: float) -> void:
	var dir := 1.0 if clockwise else -1.0
	rotate(dir * orbit_speed * delta)
