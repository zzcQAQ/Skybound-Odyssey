extends celestialBody

var normal_scale = Vector2(0.8, 0.8)

@onready var sun_sprite = $Sprite
@onready var sun_Col = $CollisionShape2D
@onready var a = get_parent().a
@onready var b = get_parent().b


func _ready() -> void:
	
	self.scale = Vector2(a, a)
	outline.scale = normal_scale

func _process(delta):
	
	self.rotate(0.1 * delta)
	
	if shown == false:
		outline.scale = outline.scale.lerp(Vector2(0.8, 0.8), delta * 10)
	else:
		outline.scale = outline.scale.lerp(Vector2(1, 1), delta * 10)
