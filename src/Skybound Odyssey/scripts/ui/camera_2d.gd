extends Camera2D

var isDrag = false
var startPosition = Vector2.ZERO
var startCamPos = Vector2.ZERO
var scaleNum = 1.0
var scaleNumNow = scaleNum


func _input(event):
	
	if event is InputEventMouseButton:
		if event.button_index in [4, 5]:
			if event.button_index == 4:
				if scaleNum >= 2: return
				scaleNum *= 1.1
			else:
				if scaleNum <= 0.2: return
				scaleNum *= 0.9

		if event.button_index == 2:
			if event.is_pressed():
				isDrag = true
				startPosition = event.position
				startCamPos = self.position
				scaleNumNow = scaleNum
			else:
				isDrag = false
				startPosition = Vector2.ZERO

	if event is InputEventMouseMotion and isDrag:
		var delta_pos = (startPosition - event.position) / scaleNumNow
		self.position = startCamPos + delta_pos
		

func _process(delta):
	self.zoom = lerp(self.zoom, Vector2(scaleNum, scaleNum), 16 * delta)
