extends NinePatchRect

var tween: Tween

func _ready() -> void:
	modulate.a = 0

func open_UI():
	if tween:
		tween.kill()
	tween = create_tween()
	
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	
func close_UI():
	if tween:
		tween.kill()
	tween = create_tween()
	
	tween.tween_property(self, "modulate.a", 0, 0.3)
