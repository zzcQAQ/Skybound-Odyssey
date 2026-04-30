class_name gameManager
extends Control

var isPlaying = false

var body: Node

func _unhandled_input(event):
	if not isPlaying or not event.is_action_pressed("click"):
		return
	var mouse_pos = get_global_mouse_position()
	var space = get_world_2d().direct_space_state
	
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	query.collide_with_areas = true
	query.collide_with_bodies = true

	var results = space.intersect_point(query)
	
	if body != null:
		body.on_deselected()
	
	if results.size() > 0:
		body = results[0].collider
		body.on_selected()
