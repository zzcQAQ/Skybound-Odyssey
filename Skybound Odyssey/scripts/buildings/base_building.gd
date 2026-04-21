#主建筑类
class BaseBuilding extends Node:
	var building_cost: float
	var level: int = 0

#发电机类
class PowerPlant extends  BaseBuilding:
	var resource_consume: float
	var power_produce: float

#挖矿机类
class MiningStation extends BaseBuilding:
	var power_consume: float
	var resource_produce: float

#科研站类
class ResearchStation extends BaseBuilding:
	var power_consume: float
	var resource_consume: float
	var research_speed: float
