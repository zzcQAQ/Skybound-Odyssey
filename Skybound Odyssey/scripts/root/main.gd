extends Node2D

@onready var control = $CanvasLayer/Control

func _ready() -> void:
	control.visible = false

func show_control():
	control.visible = true

func hide_control():
	control.visible = false
