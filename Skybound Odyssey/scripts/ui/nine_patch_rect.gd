extends NinePatchRect

var tween: Tween

var open_ui_size = size
var close_ui_size = Vector2(size.x, patch_margin_left * 2)

func _ready() -> void:
	modulate.a = 0
	size = close_ui_size


	Global.planet_selected.connect(_on_selected_planet)
	Global.giant_star_selected.connect(_on_selected_giant_star)
	Global.deselected.connect(_on_deselected)

func _on_selected_planet(_body):
	print(1)
	await get_tree().process_frame
	open_UI()

func _on_selected_giant_star(_body):
	print(2)
	await get_tree().process_frame
	open_UI()

func _on_deselected(_body):
	close_UI()



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
