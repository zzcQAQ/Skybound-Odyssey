extends Control

var tween: Tween

var open_ui_x = 1568.0
var close_ui_x = 1920

func _ready() -> void:
	
	close_UI()
	modulate.a = 0
	#接收信号
	Global.giant_star_selected.connect(_on_selected)
	Global.planet_selected.connect(_on_selected)
	Global.deselected.connect(_on_deselected)

func _on_selected(body):
	open_UI()

func _on_deselected():
	print(2)
	close_UI()

#UI动画
func open_UI():
	print(1)
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "position", Vector2(open_ui_x, position.y), 0.3)
	tween.parallel().tween_property(self, "modulate:a", 1.0, 0.3)
	
func close_UI():
	
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	tween.tween_property(self, "position", Vector2(close_ui_x, position.y), 0.3)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.3)
