extends Node
class_name Buildings

static var ALL := [

	create_building(
		"thermalPowerPlant",
		"火力发电厂",
		100,
		1,
		50
	),
	
	create_building(
		"windFarm",
		"风力农场",
		50,
		0,
		10
	),
	
	create_building(
		"solarFarm",
		"太阳能农场",
		50,
		0,
		10
	)

]

static func create_building(
	id : String,
	display_name : String,
	cost : int,
	consume : int,
	power : int
) -> BuildingData:

	var b = BuildingData.new()

	b.id = id
	b.display_name = display_name

	b.icon = load_icon(id)

	b.cost = cost
	b.consume = consume
	b.power = power

	return b


static func load_icon(id : String) -> Texture2D:
	return load("res://accests/sprites/buildings/%s.png" % id)
