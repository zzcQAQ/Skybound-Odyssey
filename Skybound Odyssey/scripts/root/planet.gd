class_name planet extends celestialBody

var planet_name: String = "Unnamed Planet"
var faction: String = "Human"
var size: String = "small"

#公转
@export var orbit_radius: float = 200.0
@export var orbit_speed: float = 1
var orbit_angle: float = 0.0

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

#六个建筑槽
var max_slots: int = 6
var buildings: Array = []

#定时更新
var _elapsed_time: float = 0.0
var update_interval: float = 1.0

func _ready():
	position = Vector2(orbit_radius, 0)

#初始化
func _init(_planet_name: String = "Unnamed Planet", _faction: String = "Human"):
	planet_name = _planet_name
	faction = _faction
	
	match size:
		"Small":
			max_slots = 4
		"Medium":
			max_slots = 6
		"Large":
			max_slots = 8
	buildings.resize(max_slots)

#行星属性更新
func _process(delta: float) -> void:
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

#加载
#func orbit_update(delta: float) -> void:
	#orbit_angle += orbit_speed * delta
	#orbit_angle = wrapf(orbit_angle, 0.0, 360.0)
	#var radians = deg_to_rad(orbit_angle)
	
