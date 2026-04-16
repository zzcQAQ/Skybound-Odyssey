extends Node2D

#生成行星数据
var orbit_radius: float
var min_gap: float = 75
var orbit_period: float # 公转周期 秒/圈
var star_angle: float
var clockwise: bool = true
var planet_count = 1
var have_water: bool

#生成恒星的数值
var luminosity: float
var star_size: float

#子节点
@onready var giant_star = $GiantStar
@onready var PlanetOrbits = $PlanetOrbits


#行星数量概率 0~8

var rng = RandomNumberGenerator.new()

var base_rng =SeedManager.get_rng(0)

func _ready():
	#恶臭种子
	rng.seed = hash(name) % 114514 * base_rng.randi()
	
	_generate_giant_star()
	
	get_planet_count()
	_generate_planets()


#=====生成恒星=====
func _generate_giant_star():
	star_size = rng.randf_range(0.5, 2)
	luminosity = rng.randf_range(1, 1.5) * star_size
	
	giant_star.star_setup(star_size, luminosity)


#=====生成行星=====

#随机行星数量
func get_planet_count():
	planet_count = int(rng.randf_range(0, 4.1 * star_size))

#生成行星轨道半径
func _generate_planets():
	var radii: Array = []
	var min_orbit = 100 * star_size
	var max_orbit = 750 * star_size

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
		var planet = preload("res://scenes/SolarSystem/PlanetType.tscn").instantiate()
		PlanetOrbits.add_child(orbit)
		orbit.add_child(planet)
		
		orbit_period = rng.randf_range(240, 900)
		have_water = rng.randf() < 0.3
		clockwise = rng.randf() < 0.9
		star_angle = rng.randf() * TAU
		
		orbit.set_radius(r, star_angle)
		orbit.orbit_period = orbit_period
		orbit.clockwise = clockwise
		
		planet.planet_setup(r, orbit_period, clockwise, giant_star, have_water)
