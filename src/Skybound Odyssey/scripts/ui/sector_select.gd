extends Node2D

@onready var camera = $Camera2D



func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(camera, "zoom", Vector2(1, 1), 0.3)
	tween.set_ease(Tween.EASE_IN_OUT)
