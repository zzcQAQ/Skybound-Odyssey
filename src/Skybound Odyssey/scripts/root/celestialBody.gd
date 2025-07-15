extends Area2D

class_name celestialBody

@onready var outline = $outline
@onready var sprite = $Sprite
@onready var CollisionShape = $CollisionShape2D

@export var shown = false

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
			shown = true
		else:
			get_tree().current_scene.hide_control()
			shown = false
