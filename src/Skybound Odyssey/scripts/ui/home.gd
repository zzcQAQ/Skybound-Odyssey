extends Control

var next_scene = preload("res://scenes/main.tscn")

@onready var currentPage = $homePage

@onready var homePage = $homePage
@onready var factionSelect = $factionSelect
@onready var settings = $settings

func NewGame() -> void:
	Animations.UIchange(homePage, factionSelect)
	currentPage = $factionSelect

func Settings() -> void:
	Animations.UIchange(homePage, settings)
	currentPage = $settings

func Back() -> void:
	Animations.UIchange(currentPage, homePage)

func Quit() -> void:
	get_tree().quit()


	#GameManager.isPlaying = true
	#self.visible = false
	#get_tree().change_scene_to_packed(next_scene)
