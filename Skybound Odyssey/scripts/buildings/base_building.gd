class_name BaseBuilding #基础建筑类
extends Node

var display_name: String
var building_cost: float
var level: int = 0
var build_time: float
var sprite: String
var sprite_node: Sprite2D

func _ready():
	load_sprite(sprite)

func load_sprite(s: String) -> Texture2D:
	var folder = "res://accests/sprites/buildings/"
	var path = folder + s + ".png"
	if FileAccess.file_exists(path):
		return load(path)
	else:
		# 找不到贴图用默认图
		return load(folder + "default.png")
