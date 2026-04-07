extends Node2D

#生成行星轨道
@export var orbit_radius: float = 50
@export var orbit_gap: float = 100
@export var orbit_speed: float = 1
@export var clockwise: bool = true
@export var planet_count = 1

@export var luminosity = 1
@export var star_size = 1.5

@onready var PlanetOrbits = $PlanetOrbits
@onready var giant_star = $GiantStar

#行星数量概率 0~8
var weights = [5, 10, 20, 30, 40, 25, 12, 5, 1]

var rng = RandomNumberGenerator.new()

var base_rng =SeedManager.get_rng(0)

func _ready():
	#恶臭种子
	rng.seed = hash(name) % 114514 * base_rng.randi()
	
	star_size = rng.randf_range(1, 2)
	luminosity = rng.randf_range(0.2, 1.5) * star_size
	
	get_planet_count()
	_generate_planets()
	
	giant_star.star_setup(star_size, luminosity)

#随机行星数量函数
func get_planet_count():
	var total = 0
	for w in weights:
		total += w

	var r = rng.randi_range(1, total)
	var sum = 0

	for i in range(weights.size()):
		sum += weights[i]
		if r <= sum:
			planet_count = i
			return

#行星与轨道部分
func _generate_planets():
	var radii: Array = []
	var min_gap = 100
	var min_orbit = 100 * star_size
	var max_orbit = 800

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

	#实例化行星
	for r in radii:
		var orbit = preload("res://scenes/SolarSystem/orbit.tscn").instantiate()
		var planet = preload("res://scenes/SolarSystem/planet.tscn").instantiate()
		
		orbit_speed = rng.randf_range(1, 5) / r
		
		PlanetOrbits.add_child(orbit)
		orbit.add_child(planet)

		orbit.set_radius(r)
		orbit.orbit_speed = rng.randf_range(1, 5) / r
		orbit.clockwise = clockwise
		planet.planet_setup(r, orbit_speed, clockwise)
		# planet节点类 转至gd脚本
