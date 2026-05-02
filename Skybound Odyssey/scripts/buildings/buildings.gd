#一大坨建筑

class CoalFiredGenerator extends PowerPlant:
	func _init() -> void:
		building_cost = 10
		level = 0
		build_time = 10
		
		resource_consume = 0.5
		
		power_produce = 10

class SmallMine extends Miner:
	func _init() -> void:
		building_cost = 5
		level = 0
		build_time = 15
		
		power_consume = 3
		
		resource_produce = 1

class SmallResearchInstitute extends ResearchStation:
	func _init() -> void:
		building_cost = 30
		level = 0
		build_time = 30
		
		resource_consume = 1
		power_consume = 5
		
		research_speed_add = 1
