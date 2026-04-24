class_name gameManager
extends Control

var isPlaying = false

func _unhandled_input(event):
	if event.is_action_released("click") and isPlaying == true:
		var mouse_pos = get_global_mouse_position()
		var space = get_world_2d().direct_space_state

		var query = PhysicsPointQueryParameters2D.new()
		query.position = mouse_pos
		query.collide_with_areas = true
		query.collide_with_bodies = true

		var results = space.intersect_point(query)
		var body: Area2D
		
		send_deselected_signal()
		if results.size() > 0:
			body = results[0].collider
			body.on_selected()
			body.send_selected_signal()
			
			

func send_deselected_signal():
	Global.deselected.emit()
