class_name celestialBody extends Node2D

#加载贴图
@onready var outline = $outline
@onready var CollisionShape = $CollisionShape2D

@export var showOutline = false
@export var lerp_scale = Vector2(0.1, 0.1)

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
			get_tree().current_scene.show_control()
			showOutline = true
		else:
			get_tree().current_scene.hide_control()
			showOutline = false

func _process(delta):
	
	if outline != null:
		if showOutline == false:
			outline.scale = outline.scale.lerp(lerp_scale, delta * 10)
		else:
			outline.scale = outline.scale.lerp(Vector2(1, 1), delta * 10)
