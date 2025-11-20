extends Node2D

#生成行星轨道
@export var orbit_radius: float = 50
@export var orbit_gap: float = 150
@export var clockwise: bool = true
@export var planet_count = 4

@export var luminosity = 1
@export var star_size = 1.5

@onready var PlanetOrbits = $PlanetOrbits
@onready var giant_star = $GiantStar

var rng = RandomNumberGenerator.new()

var base_rng = SeedManager.get_rng(0)

func _ready():
	#恶臭种子
	rng.seed = hash(name) % 114514 * base_rng.randi()
	
	get_planet_count()
	_generate_planets()
	
	star_size = rng.randf_range(1, 2)
	luminosity = rng.randf_range(0.5, 3)
	
	giant_star.star_setup(star_size, luminosity)

#随机行星数量函数 #甄姬吧难
func get_planet_count():
	var x = rng.randf_range(0, 2)
	planet_count = int(pow((x + 0.9), (-1)) * 5 - 1)

func _generate_planets():
	var radii: Array = []
	var min_gap = 100
	var min_orbit = 100 *star_size
	var max_orbit = 600

	#随机生成轨道半径数组
	for i in range(planet_count):
		var r = rng.randf_range(min_orbit, max_orbit)
		radii.append(r)

	#排序
	radii.sort()

	#加最小间隔
	for i in range(1, radii.size()):
		if radii[i] - radii[i-1] < min_gap:
			radii[i] = radii[i-1] + min_gap

	#实体化行星
	for r in radii:
		var orbit = preload("res://scenes/SolarSystem/orbit.tscn").instantiate()
		var load_planet = preload("res://scenes/SolarSystem/planet.tscn").instantiate()

		PlanetOrbits.add_child(orbit)
		orbit.add_child(load_planet)

		orbit.set_radius(r)
		orbit.orbit_speed = rng.randf_range(0.02, 0.3) / r
		orbit.clockwise = clockwise
