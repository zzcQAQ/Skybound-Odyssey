extends Node
class_name Buildings

# mdt后遗症
static var ALL := {

	"thermalPowerPlant": {
		"display_name": "Thermal Power Plant",
		"category": "power",
		"description": "Consume little resources to provide energy. Will slightly pollute the environment.",
		"cost": 50,
		"consume": 1,
		"power": 50,
		"habitability": -10
	},

	"windFarm": {
		"display_name": "Wind Farm",
		"category": "power",
		"description": "Provides a small amount of power without polluting the environment.",
		"cost": 30,
		"consume": 0,
		"power": 10
	},

	"solarFarm": {
		"display_name": "Solar Farm",
		"category": "power",
		"description": "Generates a small amount of power. Output depends on stellar brightness and distance.",
		"cost": 50,
		"consume": 0,
		"power": 10
	},
	
	"smallMine": {
		"display_name": "Small Mine",
		"category": "miner",
		"description": "Consume a small amount of energy to obtain planetary resources.",
		"cost": 30,
		"consume": 10,
		"Production": 5
	},
	
	"colonyHabitat": {
		"display_name": "Colony Habitat",
		"category": "habitat",
		"description": "Provides housing capacity and slightly improves habitability.",
		"cost": 30,
		"consume": 1,
		"power": 10,
		"habitability": 5
	},
	
	"researchLab": {
		"display_name": "Research Lab",
		"category": "strategic",
		"description": "Uses power and resources to accelerate technological research.",
		"cost": 120,
		"consume": 3,
		"power": 30,
		"researchSpeed": 10
	}
}


static func get_building(id: String) -> Dictionary:

	var building = ALL[id].duplicate()

	building["icon"] = load_icon(id)

	return building

# 自动寻找对应贴图
static func load_icon(id: String) -> Texture2D:
	
	var path = "res://accests/sprites/buildings/%s.png" % id
	
	if ResourceLoader.exists(path):
		return load(path)
	else:
		return load("res://accests/sprites/ohno.png")
