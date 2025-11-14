extends Node2D

#生成行星轨道
@export var min_orbit_radius: float = 200.0
@export var orbit_gap: float = 150.0
@export var planet_count: int = 4
@export var orbit_radius: float = 200.0
@export var clockwise: bool = randi_range(0, 1)

@onready var PlanetOrbits = $PlanetOrbits

func _ready():
	_generate_planets()

func _generate_planets():
	for i in range(planet_count):
		var orbit = preload("res://scenes/SolarSystem/orbit.tscn").instantiate()
		@warning_ignore("shadowed_global_identifier")
		var planet = preload("res://scenes/SolarSystem/planet.tscn").instantiate()

		# 轨道参数
		orbit_radius = min_orbit_radius + orbit_gap * i
		PlanetOrbits.add_child(orbit)
		orbit.add_child(planet)
		orbit.set_radius(min_orbit_radius + orbit_gap * i)
		orbit.orbit_speed = randf() * 10 / orbit_radius
		orbit.clockwise = clockwise
