class_name planet extends celestialBody

var planet_name: String = "Unnamed Planet"
var faction: String = "Human"

#加载贴图
@onready var base = $base
@onready var light = $light

#建筑格子
@onready var packed_slot = $slots
@export var slot_scene = preload("res://scenes/SolarSystem/slot.tscn")
@export var slot_count = 4
@export var angle_step = 1

#自转
@export var rotate_speed: float = -0.3
@export var rotate_rand: float = randf() * 2 * PI

#行星属性
@export var population: float = 0.1
@export var resources: float = 100
@export var energy: float = 0
@export var environment: float = 80
@export var have_water: bool = true

#行星属性增量
@export var population_rate: float = 0
@export var resources_rate: float = 0
@export var energy_rate: float = 0
@export var environment_rate: float = 0

#定时更新
var _elapsed_time: float = 0.0
var update_interval: float = 1.0

func _ready():
	lerp_scale = Vector2(0.7, 0.7)
	
	base.rotate(rotate_rand)
	light.rotate(rotate_rand)
	
	_update_slots(slot_count)

#更新建筑槽
func _update_slots(count: int) -> void:
	angle_step = TAU / count
	for i in range(count):
		var slot = slot_scene.instantiate()
		packed_slot.add_child(slot)
		var angle = angle_step * i
		slot.rotate(angle)
		slot.modulate.a = 0.0
		slot.scale = Vector2(0.5, 0.5)

func _show_slot(count: int) -> void:
	var tween = create_tween()
	for i in range(min(count, $slots.get_child_count())):
		var slot = $slots.get_child(i)
		tween.tween_property(slot, "modulate:a", 1.0, 0.3)
		tween.tween_property(slot, "scale", Vector2(1.0, 1.0), 0.3)

func _hide_slot(count: int) -> void:
	var tween = create_tween()
	for i in range(min(count, $slots.get_child_count())):
		var slot = $slots.get_child(i)
		tween.tween_property(slot, "modulate:a", 0.0, 0.3)
		tween.tween_property(slot, "scale", Vector2(0.5, 0.5), 0.3)

#行星属性更新
func _process(delta: float) -> void:
	
	#建筑槽
	super._process(delta)
	if show_UI == false:
		_hide_slot(slot_count)
	else:
		_show_slot(slot_count)
	
	#自转
	base.rotate(rotate_speed * delta)
	light.rotate(rotate_speed * delta)
	
	_elapsed_time += delta
	if _elapsed_time >= update_interval:
		_elapsed_time = 0.0
		_update_resources(update_interval)
		_update_environment(update_interval)
		_update_population(update_interval)

func _update_resources(delta: float) -> void:
	resources += resources_rate * delta
	if resources < 0: resources = 0

func _update_environment(delta: float) -> void:
	if have_water:
		environment += environment_rate * delta * 1.2
	else:
		environment += environment_rate * delta
	environment = clamp(environment, 0, 100)
		
func _update_population(delta: float) -> void:
	if faction == "Human":
		population += population_rate * delta
		if population < 0: population = 0

func _update_energy(delta: float) -> void:
	energy += energy_rate * delta
	if energy < 0: energy = 0

#整数化展示值
func get_display_values() -> Dictionary:
	return {
		"resources": int(resources),
		"energy": int(energy),
		"population": int(population),
		"environment": int(environment)
	}
