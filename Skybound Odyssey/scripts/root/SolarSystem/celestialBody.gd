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

#鼠标点击判定  #纯屎
func _input(event):
	if event.is_action_pressed("click") and GameManager.isPlaying:
		var mouse_pos = get_global_mouse_position()
		
		var space = get_world_2d().direct_space_state
		
		var query = PhysicsPointQueryParameters2D.new()
		query.position = mouse_pos
		query.collide_with_areas = true
		query.collide_with_bodies = false
		
		var result = space.intersect_point(query)
		
		var hit_self = result.any(func(result):
			return result.collider == self
		)
		
		if hit_self:
			
			await get_tree().process_frame
			send_selected_signal()
			
			if show_UI == false:
				show_UI = true
				selection_root.show_arrow()
			
		else:
			show_UI = false
			selection_root.hide_arrow()
			Global.emit_signal("deselected", self)


func send_selected_signal():
	pass
