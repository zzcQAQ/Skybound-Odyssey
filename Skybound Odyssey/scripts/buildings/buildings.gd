extends Node
class_name Buildings


static var ALL := {

	"thermalPowerPlant": {
		"display_name": "Thermal Power Plant",
		"description": "Consume little resources to provide energy. Will slightly pollute the environment.",
		"cost": 100,
		"consume": 1,
		"power": 50
	},

	"windFarm": {
		"display_name": "Wind Farm",
		"description": "Provides a small amount of power without polluting the environment.",
		"cost": 50,
		"consume": 0,
		"power": 10
	},

	"solarFarm": {
		"display_name": "Solar Farm",
		"description": "Generates a small amount of power. Output depends on stellar brightness and distance.",
		"cost": 70,
		"consume": 0,
		"power": 10
	},
	
	"smallMine": {
		"display_name": "Small Mine",
		"description": "Consume a small amount of energy to obtain planetary resources.",
		"cost": 50,
		"consume": 10,
		"Production": 3
	}
}


static func get_building(id: String) -> Dictionary:

	var building = ALL[id].duplicate()

	building["icon"] = load_icon(id)

	return building


static func load_icon(id: String) -> Texture2D:
	return load("res://accests/sprites/buildings/%s.png" % id)
