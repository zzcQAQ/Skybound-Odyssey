extends Node

var my_seed: int = 114514

func get_rng(key: String) -> RandomNumberGenerator:
	var rng = RandomNumberGenerator.new()
	rng.seed = hash(str(seed) + key)
	return rng
