extends NinePatchRect

var tween: Tween

var open_ui_size = size
var close_ui_size = Vector2(size.x, patch_margin_left * 2)

var current_selected = 0
var current_selected_body = null

@onready var giant_star_panel = $MarginContainer/DataList/GiantStarPannel
@onready var planet_panel = $MarginContainer/DataList/PlanetPanel

func _ready() -> void:
	#初始化动画
	modulate.a = 0
	size = close_ui_size
	#接收信号
	
	Global.giant_star_selected.connect(_on_selected_giant_star)
	Global.planet_selected.connect(_on_selected_planet)
	Global.deselected.connect(_on_deselected)

#分类选择
func _on_selected_giant_star(body):
	current_selected = 1
	current_selected_body = body
	update_display(current_selected)
	open_UI()

func _on_selected_planet(body):
	current_selected = 2
	current_selected_body = body
	update_display(current_selected)
	open_UI()

func _on_deselected(_body):
	current_selected = 0
	close_UI()

var ui_timer := 0.0
var ui_interval := 1.0 / 1.0 #一秒1刀

func _process(delta):
	if current_selected == 0:
		return
	
	ui_timer += delta
	
	if ui_timer >= ui_interval:
		update_display(current_selected)
		ui_timer = 0.0

func update_display(a):
	print(a)
	if a == 1:
		planet_panel.visible = false
		giant_star_panel.visible = true
		giant_star_panel.get_node("RadiusLabel").text = "Radius: " + str("%.2f R☉" % (current_selected_body.radius / 72))
		giant_star_panel.get_node("LuminosityLabel").text = "Luminosity: " + str("%.2f L☉" % current_selected_body.luminosity)
	if a == 2:
		giant_star_panel.visible = false
		planet_panel.visible = true
		#planet_panel.get_node("IdLabel").text = "ID: " + str(current_selected_body.name)
		planet_panel.get_node("OrbitRadiusLabel").text = "OrbitRadius: " + str("%.2f AU" % current_selected_body.orbit_AU)
		planet_panel.get_node("OrbitPeriodLabel").text = "OrbitPeriod: " + str("%.0f d" % current_selected_body.orbit_period)
		planet_panel.get_node("PopulationLabel").text = "Population: " + str(current_selected_body.population)
		planet_panel.get_node("MaterialsLabel").text = "Materials: " + str(current_selected_body.materials)
		planet_panel.get_node("HabitabilityLabel").text = "Habitability: " + str("%.2f " % current_selected_body.habitability) + "%"
		if current_selected_body.habitability_temp > 0:
			planet_panel.get_node("HabitabilityContainer/HabitabilityRateLabel").text = "temperature: +" + str("%.2f " % current_selected_body.habitability_temp) + "%"
			planet_panel.get_node("HabitabilityContainer/HabitabilityRateLabel").add_theme_color_override("font_color", Color(0.0, 1.0, 0.0, 1.0))
		else:
			planet_panel.get_node("HabitabilityContainer/HabitabilityRateLabel").text = "temperature: " + str("%.2f " % current_selected_body.habitability_temp) + "%"
			planet_panel.get_node("HabitabilityContainer/HabitabilityRateLabel").add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))
		planet_panel.get_node("TemperatureLabel").text = "temperature: " + str("%.0f K" % (current_selected_body.temperature))
#UI动画
func open_UI():
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "modulate:a", 1.0, 0.5)
	tween.parallel().tween_property(self, "size", open_ui_size, 0.5)
	
func close_UI():
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.parallel().tween_property(self, "size", close_ui_size, 0.5)
