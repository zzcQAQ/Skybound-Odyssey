extends VBoxContainer

func _ready():
	#默认显示发电类
	change_select("Power")

#更改当前选中的分类
func change_select(i: String):
	#显示其他分割线
	for button in get_children():
		if button is TextureButton:
			button.get_child(0).visible = true
	#隐藏当前选中的分割线
	get_node(i).get_child(0).visible = false

	
