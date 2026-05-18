extends VBoxContainer

@export var button_scene : PackedScene

func _ready():

	for id in Buildings.ALL:
		
		var data = Buildings.get_building(id)
		var button = button_scene.instantiate()
		
		add_child(button)
		
		button.set_building(data)
		
		change_category("power")
		
		
func change_category(c: String):
	for button in get_children():
		if button.category == c:
			button.visible = true
		else:
			button.visible = false
