extends VBoxContainer

@export var button_scene : PackedScene

func _ready():

	for building in Buildings.ALL:

		var button = button_scene.instantiate()

		add_child(button)

		button.set_building(building)
