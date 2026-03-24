class_name CelestialBody
extends Node2D

#加载贴图
@onready var CollisionShape = $CollisionShape2D
@onready var show_UI = false
@export var lerp_scale = Vector2(0.9, 0.9)

@onready var selection_root = $SelectionRoot

var rng = RandomNumberGenerator.new()

func _ready():
	selection_root.visible = false
	
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
			selection_root.visible = true
			
		else:
			show_UI = false
			selection_root.visible = false

	
func _process(delta: float) -> void:
	pass
