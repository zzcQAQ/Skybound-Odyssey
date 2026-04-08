class_name Planet
extends CelestialBody

var planet_name: String = "Unnamed Planet"
var faction = 0

#加载贴图
@onready var base = $base
@onready var light = $light

#用于选中箭头
@export var radius = 16

#自转
@export var rotate_speed: float = -0.3
@export var rotate_rand: float = randf() * 2 * PI * 0.05

#行星属性
#planet.planet_setup(r, orbit_speed, clockwise)
@export var population: float = 0.1
@export var materials: float = 100
@export var power_generation: float = 0
@export var power_consumption: float = 0
@export var habitability: float = 80
@export var have_water: bool = true
@export var orbit_radius: float
@export var distance_AU: float
@export var orbit_period: float
@export var clockwise: bool = true

#属性增量(每秒)
@export var population_rate: float = 0
@export var materials_production_rate: float = 0
@export var materials_consumption_rate: float = 0
@export var habitability_rate: float = 0

func _ready():
	#隐藏箭头
	selection_root.visible = false
	
	#自转动画
	

#显示UI
func send_selected_signal():
	Global.emit_signal("planet_selected", self)

func _process(delta: float) -> void:
	base.rotate(rotate_rand * delta)
	light.rotate(rotate_rand * delta)


	#========行星数据更新与调用========#

#func get_planet_data() -> Dictionary: #数据字典，好像没啥用
	#return {
		#"population": population,
		#"materials": materials,
		#"power_generation": power_generation,
		#"power_consumption": power_consumption,
		#"habitability": habitability,
		#"population_rate": population_rate,
		#"materials_production_rate": materials_production_rate,
		#"materials_consumption_rate": materials_consumption_rate,
		#"habitability_rate": habitability_rate
	#}

var update_interval := 1.0 / 10.0  #一秒10刀
var update_timer := 0.0

func planet_setup(radius, period, cw):
	orbit_radius = radius
	distance_AU = radius / 300
	orbit_period = period
	clockwise = cw

func _physics_process(delta: float) -> void:
	update_timer += delta
	
	if update_timer >= update_interval:
		update_data(update_timer)  #真实累计时间
		update_timer = 0.0

func update_data(delta: float) -> void: #更新数据
	update_population(delta)
	update_materials(delta)
	update_habitability(delta)

func update_power(delta:float) -> void: #power比较特殊，不在一起更新
	pass

func update_population(delta: float) -> void:
	population += population_rate * delta
	if population < 0:
		population = 0

func update_materials(delta: float) -> void:
	materials += (materials_production_rate - materials_consumption_rate) * delta
	if materials < 0:
		materials = 0
	
func update_habitability(delta: float) -> void:
	habitability += habitability_rate * delta
	habitability = clamp(habitability, 0.0, 100.0)
