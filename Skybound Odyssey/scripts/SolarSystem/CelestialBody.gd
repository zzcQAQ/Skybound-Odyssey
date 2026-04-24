class_name CelestialBody
extends Node2D

#加载贴图
@onready var CollisionShape = $CollisionShape2D
@onready var show_UI = false
@export var lerp_scale = Vector2(0.9, 0.9)

@onready var selection_root = $SelectionRoot

func _ready():
	selection_root.visible = false
	#Global.connect("deselected", Callable(self, "on_deselected"))

func on_selected():
	selection_root.show_arrow()

#func on_deselected(body):
	#selection_root.hide_arrow()


##鼠标点击判定  #纯屎
#func _input(event):
	## 只在点击且游戏运行时处理
	#if not (event.is_action_released("click") and GameManager.isPlaying):
		#return
	#
	#var mouse_pos = get_global_mouse_position()
	#var space_state = get_world_2d().direct_space_state
	#
	## 构造查询参数
	#var query := PhysicsPointQueryParameters2D.new()
	#query.position = mouse_pos
	#query.collide_with_areas = true
	#query.collide_with_bodies = false
	#
	## 获取点击到的所有对象
	#var results := space_state.intersect_point(query)
	##print(results.size())
	#
	## 判断是否点到了自己
	#var hit_self := false
	#for r in results:
		#if r.collider == self:
			#hit_self = true
			#break
	#
	#if hit_self:
		## 避免同帧重复触发
		#await get_tree().process_frame
		#
		#send_selected_signal()
		#
		## 只有状态变化时才更新 UI（避免重复调用）
		#if not show_UI:
			#show_UI = true
			#selection_root.show_arrow()
	#
	#else:
		#if show_UI:
			#show_UI = false
			#selection_root.hide_arrow()
		#
		#Global.emit_signal("deselected", self)
#
#
#func send_selected_signal():
	#pass
