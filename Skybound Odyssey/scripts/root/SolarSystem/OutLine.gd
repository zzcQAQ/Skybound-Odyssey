extends Line2D

@export var radius: float = 21.0     # 半径
@export var base_width: float = 3.0    # 宽
@export var color: Color = Color(0.0, 0.85, 1.0, 1.0)
@export var segments: int = 64       # 细分精度

func _ready():
	var p = get_parent()
	radius = p.get_outline_radius()
	default_color = color
	build_circle()


func _process(delta):
	var cam = get_viewport().get_camera_2d()
	if cam:
		width = base_width / cam.zoom.x

func build_circle():
	var pts = []
	for i in range(segments + 1):
		var angle = TAU * i / segments
		var p = Vector2(cos(angle), sin(angle)) * radius
		pts.append(p)
	points = pts
