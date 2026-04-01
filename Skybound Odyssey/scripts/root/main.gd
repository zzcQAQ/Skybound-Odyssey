extends Node2D

@onready var ninePatchRect = $CanvasLayer/UI/NinePatchRect

func open_UI():
	ninePatchRect.open_UI()

func close_UI():
	ninePatchRect.close_UI()
