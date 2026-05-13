extends VBoxContainer

@export var button_scene : PackedScene

func _ready():

	for id in Buildings.ALL:
		
		var data = Buildings.get_building(id)
		var button = button_scene.instantiate()
		
		add_child(button)
		
		button.set_building(data)
