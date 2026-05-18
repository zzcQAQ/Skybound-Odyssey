extends VSeparator

@export var sizey: float

func _ready() -> void:
	sizey = owner.size.y - 16
	size.y = sizey / 4
