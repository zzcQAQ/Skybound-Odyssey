extends VBoxContainer

@export var building_button_scene: PackedScene

# 从 buildings.gd 读取所有建筑数据（只需在那一个文件里维护）
const BuildingsSrc = preload("res://scripts/buildings/buildings.gd")

func _ready():
	# 清除编辑器中预置的示例按钮
	for child in get_children():
		child.queue_free()

	for bld in BuildingsSrc.BUILDING_NAMES:
		var button_instance = building_button_scene.instantiate()

		# 设置建筑名标签
		var label_node = button_instance.get_node("MarginContainer/HBoxContainer/VBoxContainer/Label")
		var display_name: String = BuildingsSrc.BUILDING_DISPLAY_NAMES.get(bld, bld)
		label_node.text = display_name

		# 保存建筑类名到按钮元数据，方便点击时使用
		button_instance.set_meta("building_class_name", bld)

		add_child(button_instance)
