extends NinePatchRect

var tween: Tween

var open_ui_size = Vector2(448, 952)
var close_ui_size = Vector2(448, 0)

func _ready() -> void:
	modulate.a = 0
	size = close_ui_size


	Global.planet_selected.connect(_on_selected)
	Global.planet_deselected.connect(_on_deselected)

func _on_selected(body):
	open_UI()

func _on_deselected(body):
	close_UI()


func open_UI():
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	tween.parallel().tween_property(self, "size", open_ui_size, 0.3)
	
func close_UI():
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	tween.parallel().tween_property(self, "size", close_ui_size, 0.3)
