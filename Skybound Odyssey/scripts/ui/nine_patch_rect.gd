extends NinePatchRect

var tween: Tween

var open_ui_size = size
var close_ui_size = Vector2(size.x, patch_margin_left * 2)

var current_selected = 0

@onready var giant_star_panel = $MarginContainer/DataList/GiantStarPannel
@onready var planet_panel = $MarginContainer/DataList/PlanetPanel

func _ready() -> void:
	#初始化动画
	modulate.a = 0
	size = close_ui_size
	#接收信号
	
	Global.planet_selected.connect(_on_selected_planet)
	Global.giant_star_selected.connect(_on_selected_giant_star)
	Global.deselected.connect(_on_deselected)

#分类选择
func _on_selected_giant_star(_body):
	current_selected = 1
	await get_tree().process_frame
	open_UI()

func _on_selected_planet(_body):
	current_selected = 2
	await get_tree().process_frame
	open_UI()

func _on_deselected(_body):
	current_selected = 0
	close_UI()

#更新数据
func _physics_process(delta: float) -> void:
	if current_selected == 0:
		return
	update_display(current_selected)

func update_display(a):
	if a == 1:
		pass
	if a == 2:
		pass

#UI动画
func open_UI():
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "modulate:a", 1.0, 0.5)
	tween.parallel().tween_property(self, "size", open_ui_size, 0.5)
	
func close_UI():
	print(3)
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.parallel().tween_property(self, "size", close_ui_size, 0.5)
