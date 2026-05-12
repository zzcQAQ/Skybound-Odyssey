extends Node
class_name Buildings

static var ALL := [

	create_building(
		"thermalPowerPlant",
		"火力发电厂",
		preload("res://accests/sprites/buildings/thermalPowerPlant.png"),
		100,
		50
	)

]

static func create_building(
	id,
	display_name,
	icon,
	cost,
	power
):

	var b = BuildingData.new()

	b.id = id
	b.display_name = display_name
	b.icon = icon
	b.cost = cost
	b.power = power

	return b
