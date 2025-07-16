extends Node2D

@onready var control = $CanvasLayer/Control

func show_control():
	control.visible = true

func hide_control():
	control.visible = false
