extends VBoxContainer

func _ready():
	#默认显示发电类
	change_select("power")

#按钮输入
func change_select(i: String):
	#更改当前选中的分类
	for button in get_children():
		if button is TextureButton:
			var vseparator = button.get_child(0)
			button.modulate.a = 0.3
			vseparator.visible = true
			vseparator.modulate.a = 10
	
	get_node(i).get_child(0).visible = false
	get_node(i).modulate.a = 1.0
	
	#更改建筑选项筛选
	get_parent().get_node("MarginContainer/ButtonsManager").change_category(i)

	
