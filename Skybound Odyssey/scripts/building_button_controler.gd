extends VBoxContainer

func show_other_lines():
	for child in get_children():
		if child is BuildingCategoryButton:
			child.show_line()
