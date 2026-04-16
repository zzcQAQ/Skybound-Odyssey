class_name PlanetType
extends CelestialBody

var planet_name: String = "Unnamed Planet"
var faction = 0

#用于选中箭头
@export var radius = 16

#自转
@export var rotate_speed: float = -0.3
@export var rotate_rand: float = randf() * 2 * PI * 0.05

#行星属性
@export var population: float = 0.1
@export var materials: float = 100
@export var power_generation: float = 0
@export var power_consumption: float = 0
@export var temperature: float #开氏温度
#宜居度
@export var habitability: float = 50
@export var habitability_temp: float = 0


@export var have_water: bool
@export var orbit_radius: float
@export var orbit_AU: float
@export var orbit_period: float
@export var clockwise: bool = true

#获取父级恒星
@export var star_luminosity: float
@export var star_size: float

#属性增量(每秒)
@export var population_rate: float = 0
@export var materials_production_rate: float = 0
@export var materials_consumption_rate: float = 0


func _ready():
	#隐藏箭头
	selection_root.visible = false

#显示UI
func send_selected_signal():
	Global.emit_signal("planet_selected", self)


#初始化行星
func planet_setup(radius, period, cw, s, h_w):
	orbit_radius = radius
	orbit_AU = radius / 200
	orbit_period = period
	clockwise = cw
	star_luminosity = s.luminosity #恒星光度，算气温用的
	star_size = s.size
	have_water = h_w
	
	update_temperature()
	update_water()
	update_habitability()
	update_sprite()

	#========行星贴图匹配========#
	
#加载贴图
@onready var base_sprites = $BaseSprites
@onready var base_sprite: String
@onready var light_sprites = $LightSprites
@onready var light_sprite: String

#贴图匹配
func update_sprite():
	
	if temperature > 1000: #熔岩
		base_sprite = "LavaPlanet"
		light_sprite = "MoltenPlanetLight"
	else:
		base_sprite = "BarrenPlanet" #岩石
		light_sprite = "NoSprite"
	
	if habitability >= 50 and have_water: #宜居
		base_sprite = "base"
		light_sprite = "BaseLight"
	
	if temperature <= 178 and have_water: #冻土
		base_sprite = "FrozenPlanet"
		light_sprite = "NoSprite"
	
	for child in base_sprites.get_children():
		child.visible = false
	base_sprites.get_node(base_sprite).visible = true
	
	for child in light_sprites.get_children():
		child.visible = false
	if light_sprite != "NoSprite":
		light_sprites.get_node(light_sprite).visible = true

#自转
func _process(delta: float) -> void:
	base_sprites.rotate(rotate_rand * delta)
	light_sprites.rotate(rotate_rand * delta)


	#========行星数据更新与调用========#

var update_interval := 1.0 / 10.0  #一秒10刀
var update_timer := 0.0

func _physics_process(delta: float) -> void:
	update_timer += delta
	
	if update_timer >= update_interval:
		update_data(update_timer)  #真实累计时间
		update_timer = 0.0

func update_data(delta: float) -> void: #更新数据
	update_population(delta)
	update_materials(delta)
	#update_habitability(delta)
	#update_temperature()

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
	
func update_habitability():
	habitability_temp = -pow((temperature - 288.0) / 10.0, 2) + 50.0
	habitability = 0 + habitability_temp
	if have_water:
		habitability += 30
	habitability = clamp(habitability, 0.0, 100.0)

func update_temperature():
	temperature = 278 * star_luminosity * pow((2 / orbit_AU), 1.5)
	update_sprite()

func update_water():
	if temperature >= 1000:
		have_water = false
