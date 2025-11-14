extends Camera2D

var isDrag = false
var start_mouse_pos = Vector2.ZERO
var start_cam_pos = Vector2.ZERO
var scaleNum = 1.0
var scaleNumNow = scaleNum
var target_position = Vector2.ZERO

func _ready():
	target_position = position

func _input(event):
	
	if event is InputEventMouseButton:
		if event.button_index in [4, 5]:
			if event.button_index == 4:
				if scaleNum >= 3: return
				scaleNum *= 1.1
			else:
				if scaleNum <= 0.2: return
				scaleNum *= 0.9

		if event.button_index == 2:
			if event.is_pressed():
				isDrag = true
				start_mouse_pos = event.position
				start_cam_pos = self.position
				scaleNumNow = scaleNum
			else:
				isDrag = false
				start_mouse_pos = Vector2.ZERO

	if event is InputEventMouseMotion and isDrag:
		var delta_pos = (start_mouse_pos - event.position) / scaleNumNow
		target_position = start_cam_pos + delta_pos
		

func _process(delta):
	self.zoom = lerp(self.zoom, Vector2(scaleNum, scaleNum), 16 * delta)
	position = position.lerp(target_position, 20 * delta)
