extends NinePatchRect

@export var have_buildings: bool = false

@onready var HaveBuildingsContainer = $MarginContainer/HaveBuildingsContainer
@onready var NoBuildingsContainer = $MarginContainer/NoBuildingsContainer
@onready var BuildingPicker = $BuildingPicker

func _ready() -> void:
	
	BuildingPicker.visible = false
	Global.deselected.connect(_on_deselected)
	Global.deselected_slot.connect(_on_deselected)
	
	if have_buildings == false:
		HaveBuildingsContainer.visible = false
		NoBuildingsContainer.visible = true
	else:
		NoBuildingsContainer.visible = false
		HaveBuildingsContainer.visible = true
	
	#延迟执行 约束建筑选择框位置
	await get_tree().process_frame
	_clamp_building_picker_position()

func _on_pressed() -> void:
	Global.deselected_slot.emit()
	BuildingPicker.visible = true

func _on_deselected():
	BuildingPicker.visible = false

#约束建筑选择框位置
var global_pos: Vector2
var viewport_size: Vector2
var picker_size: Vector2

func _clamp_building_picker_position() -> void:
	global_pos = global_position + Vector2(-352, -128)
	viewport_size = get_viewport_rect().size
	picker_size = BuildingPicker.size
	
	global_pos.y = clampf(global_pos.y, 8, viewport_size.y - picker_size.y - 8)
	
	BuildingPicker.position = global_pos - global_position

#选择框动画

var tween: Tween

#func open_building_picker():
	#if tween:
		#tween.kill()
	#tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	#
	#tween.tween_property(self, "position", Vector2(open_ui_x, position.y), 0.3)
	#tween.parallel().tween_property(self, "modulate:a", 1.0, 0.3)
	#
#func close_building_picker():
	#if tween:
		#tween.kill()
	#tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	#
	#tween.tween_property(self, "position", Vector2(close_ui_x, position.y), 0.3)
	#tween.parallel().tween_property(self, "modulate:a", 0.0, 0.3)
