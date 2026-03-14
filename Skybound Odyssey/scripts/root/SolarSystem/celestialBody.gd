class_name celestialBody extends Node2D

#加载贴图
@onready var outline = $outline
@onready var CollisionShape = $CollisionShape2D
@onready var show_UI = false
@export var lerp_scale = Vector2(0.9, 0.9)

var rng = RandomNumberGenerator.new()

func _ready():
	rng.seed = 1

func _input(event):

	if event.is_action_pressed("click") and GameManager.isPlaying == true:
		var mouse_pos = get_global_mouse_position()

		var space = get_world_2d().direct_space_state
		var query = PhysicsPointQueryParameters2D.new()
		query.position = mouse_pos
		query.collide_with_areas = true
		query.collide_with_bodies = false
		
		var collisions = space.intersect_point(query)
		
		var hit_self = collisions.any(func(result):
			return result.collider == self
		)
		
		if hit_self:
			show_UI = true
		else:
			show_UI = false

func _process(delta: float) -> void:
	if outline != null:
		if show_UI == false:
			
			outline.scale = outline.scale.lerp(lerp_scale, delta * 10)
		else:
			
			outline.scale = outline.scale.lerp(Vector2(1, 1), delta * 10)
