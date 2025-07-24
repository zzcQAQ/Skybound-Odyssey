extends Control

var sector_Select = preload("res://scenes/ui/sector_Select.tscn")
var mainScene = preload("res://scenes/main.tscn")

@onready var currentPage = $CanvasLayer/homePage

@onready var homePage = $CanvasLayer/homePage

@onready var factionSelect = $CanvasLayer/factionSelect
@onready var human = $CanvasLayer/factionSelect/preview/human
@onready var flesh = $CanvasLayer/factionSelect/preview/flesh

@onready var settings = $CanvasLayer/settings

@onready var camera = $Camera2D

# homePage
func CampaignMode() -> void:
	Animations.UIchange(homePage, factionSelect)
	currentPage = $CanvasLayer/factionSelect

func Continue() -> void:
	Animations.UIhide(homePage)
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_packed(mainScene)
	GameManager.isPlaying = true

func NewGame() -> void:
	Animations.UIchange(homePage, factionSelect)
	currentPage = $CanvasLayer/factionSelect

func Settings() -> void:
	Animations.UIchange(homePage, settings)
	currentPage = $CanvasLayer/settings

func Quit() -> void:
	get_tree().quit()

# factionSelect
func Human() -> void:
	Animations.UImove(human, human.position, Vector2(200, 350), 0.3)
	Animations.UImove(flesh, flesh.position, Vector2(-900, 350), 0.3)
	print(human.position.x, human.position.y)
	print(flesh.position.x, flesh.position.y)
	GameManager.faction = 1

func Flesh() -> void:
	Animations.UImove(flesh, flesh.position, Vector2(200, 350), 0.3)
	Animations.UImove(human, human.position, Vector2(-900, 350), 0.3)
	GameManager.faction = 2

func Confirm() -> void:
	if GameManager.faction != 0:
		Animations.UIhide(factionSelect)
		Animations.UImove(human, human.position, Vector2(-900, 350), 0.3)
		Animations.UImove(flesh, flesh.position, Vector2(-900, 350), 0.3)
		ChangeScene()
		await get_tree().create_timer(0.3).timeout
		homePage.visible = 0
		factionSelect.visible = 0
		settings.visible = 0
		get_tree().change_scene_to_packed(sector_Select)

# all
func Back() -> void:
	if GameManager.faction != 0 :
		Animations.UImove(human, human.position,Vector2(-900, 350), 0.3)
		Animations.UImove(flesh, flesh.position, Vector2(-900, 350), 0.3)
	GameManager.faction = 0
	Animations.UIchange(currentPage, homePage)

func ChangeScene():
	var tween = create_tween()
	tween.tween_property(camera, "zoom", Vector2(0, 0), 0.3)
	tween.set_ease(Tween.EASE_IN_OUT)
	
