extends Node

@export var size: float
@export var luminosity: float
@export var rotateSpeed: int

func _ready():
	var baseRng = RandomNumberGenerator.new()
	var numbers = 10
	
	#baseRng.seed = 42
	#var randomGroup = []
	#for i in range(numbers):
		#randomGroup.append(baseRng.randf())


	size = baseRng.randf() + 0.5
	luminosity = baseRng.randf() * 3
	rotateSpeed = baseRng.randi() % 2 + 1
