extends Node2D

# 生成行星轨道
@export var orbit_radius: float
@export var min_gap: float = 75
@export var orbit_period: float # 公转周期 秒/圈
@export var clockwise: bool = true
@export var planet_count = 1

# 生成恒星的数值
@export var luminosity: float
@export var star_size: float

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


# 生成恒星
func _generate_giant_star():
	star_size = rng.randf_range(0.5, 2)
	luminosity = rng.randf_range(1, 1.5) * star_size
	
	giant_star.star_setup(star_size, luminosity)


#随机行星数量函数
func get_planet_count():
	planet_count = int(rng.randf_range(0, 4.1 * star_size))

#行星与轨道部分
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
		var planet = preload("res://scenes/SolarSystem/planet.tscn").instantiate()
		
		PlanetOrbits.add_child(orbit)
		orbit.add_child(planet)
		
		orbit_period = rng.randf_range(240, 900)
		
		orbit.set_radius(r)
		orbit.orbit_period = orbit_period
		orbit.clockwise = clockwise
		planet.planet_setup(r, orbit_period, clockwise, giant_star)
