extends Node

@export var world_seed: int = 114514

func set_seed(seed: int):
	world_seed = seed


func get_rng(offset: int = 0) -> RandomNumberGenerator:
	var rng = RandomNumberGenerator.new()
	rng.seed = world_seed + offset
	return rng
