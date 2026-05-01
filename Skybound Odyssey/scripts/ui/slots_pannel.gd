extends NinePatchRect

@export var have_buildings: bool = false

@onready var HaveBuildingsContainer = $MarginContainer/HaveBuildingsContainer
@onready var NoBuildingsContainer = $MarginContainer/NoBuildingsContainer
@onready var BuildingPicker = $BuildingPicker

# 约束建筑选择框位置
var global_pos: Vector2
var viewport_size: Vector2
var picker_size: Vector2

# 选择框动画
var tween: Tween
var show_pos: Vector2
var hide_pos: Vector2

func _ready() -> void:
	
	BuildingPicker.visible = false
	BuildingPicker.modulate.a = 0.0
	
	Global.deselected.connect(_on_deselected)
	Global.deselected_slot.connect(_on_deselected)
	
	if have_buildings == false:
		HaveBuildingsContainer.visible = false
		NoBuildingsContainer.visible = true
	else:
		NoBuildingsContainer.visible = false
		HaveBuildingsContainer.visible = true
	
	#延迟执行
	await get_tree().process_frame
	_clamp_building_picker_position()
	get_movement_pos()

func _on_pressed() -> void:
	Global.deselected_slot.emit()
	show_building_picker()

func _on_deselected():
	hide_building_picker()

func _clamp_building_picker_position() -> void:
	global_pos = global_position + Vector2(-352, -128)
	viewport_size = get_viewport_rect().size
	picker_size = BuildingPicker.size
	
	global_pos.y = clampf(global_pos.y, 8, viewport_size.y - picker_size.y - 8)
	
	BuildingPicker.position = global_pos - global_position

func get_movement_pos():
	show_pos = BuildingPicker.position
	hide_pos = BuildingPicker.position + Vector2(32, 0)

func show_building_picker():
	if tween:
		tween.kill()
	
	BuildingPicker.position = hide_pos
	BuildingPicker.modulate.a = 0.0
	BuildingPicker.visible = true
	
	tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(BuildingPicker, "position", show_pos, 0.3)
	tween.parallel().tween_property(BuildingPicker, "modulate:a", 1.0, 0.3)

func hide_building_picker():
	if tween:
		tween.kill()
	
	tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property(BuildingPicker, "position", hide_pos, 0.3)
	tween.parallel().tween_property(BuildingPicker, "modulate:a", 0.0, 0.3)
	tween.tween_callback(func(): BuildingPicker.visible = false)
