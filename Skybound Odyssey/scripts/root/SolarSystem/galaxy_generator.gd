extends Node2D

# 种子随机
var rng = RandomNumberGenerator.new()

# 生成范围
@export var map_size = Vector2(160000, 90000)
@export var solar_system_count := 50
@export var min_distance := 5000
@export var max_attempts_per_system: int = 3

# 获取节点
@onready var solar_system = preload("res://scenes/SolarSystem/solar_system.tscn")

# 建立位置
var systems_positions = []

# 立即执行
func _ready():
	
	rng.seed = 114514
	generate_solar_systems()



# ==========生成星系========== #

#总生成函数  # 星系越多，星系越少
func generate_solar_systems():
	var success: int = 0
	for i in solar_system_count:
		var pos = find_valid_position()
		if pos != null: 
			systems_positions.append(pos)
			spawn_system(pos, i)
			success += 1
			
	print("生成成功：", success, " 生成失败：", solar_system_count - success)

#随机位置并判定可用性
func find_valid_position():
	for i in max_attempts_per_system:
		var pos = Vector2(
			rng.randf_range(0, map_size.x),
			rng.randf_range(0, map_size.y)
		)
		
		if is_valid_position(pos):
			return pos
	
	return null

#位置可用判定函数
func is_valid_position(pos: Vector2) -> bool:
	
	for p in systems_positions:
		if pos.distance_to(p) < min_distance:
			return false
		
	return true

#实例化星系
func spawn_system(pos: Vector2, id):
	var system = solar_system.instantiate()
	self.add_child(system)
	system.system_setup(pos, id)
