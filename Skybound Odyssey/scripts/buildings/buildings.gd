#一大坨建筑

# 所有建筑类名列表，供 buttons_manager 遍历（只在这里维护一次）
const BUILDING_NAMES := [
"thermalPowerPlant",
"SmallMine",
"SmallResearchInstitute",
]

# 类名 → 显示名称（也只在这里维护一次）
const BUILDING_DISPLAY_NAMES := {
"thermalPowerPlant": "Thermal Power Plant",
"SmallMine": "Small Mine",
"SmallResearchInstitute": "Small Research Institute",
}

class thermalPowerPlant extends PowerPlant:
	func _init() -> void:
		display_name = "Thermal Power Plant"
		building_cost = 10
		level = 0
		build_time = 10
		resource_consume = 0.5
		power_produce = 10

class SmallMine extends Miner:
	func _init() -> void:
		display_name = "Small Mine"
		building_cost = 5
		level = 0
		build_time = 15
		power_consume = 3
		resource_produce = 1

class SmallResearchInstitute extends ResearchStation:
	func _init() -> void:
		display_name = "Small Research Institute"
		building_cost = 30
		level = 0
		build_time = 30
		resource_consume = 1
		power_consume = 5
		research_speed_add = 1
