extends celestialBody

@onready var a = get_parent().a


func _ready() -> void:
	outline.scale = Vector2(0.7, 0.7)
	sprite.position = Vector2(a * 100, 0)
	CollisionShape.position = Vector2(a * 100, 0)
	outline.position = Vector2(a * 100, 0)
	
func _process(delta):
	self.rotate(-0.05 * delta)
	
	if shown == false:
		outline.scale = outline.scale.lerp(Vector2(0.7, 0.7), delta * 10)
	else:
		outline.scale = outline.scale.lerp(Vector2(1, 1), delta * 10)
