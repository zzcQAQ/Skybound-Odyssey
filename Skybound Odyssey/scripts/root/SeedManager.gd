extends Node

var my_seed: int = 114514
#var rng := RandomNumberGenerator.new()

#func set_seed(new_seed: int):
	#my_seed = new_seed
	#rng.seed = my_seed
#
#func randf():
	#return rng.randf()
#
#func randi():
	#return rng.randi()
#
#func randf_range(a, b):
	#return rng.randf_range(a, b)

func get_rng(key: String) -> RandomNumberGenerator:
	var rng = RandomNumberGenerator.new()
	rng.seed = hash(str(seed) + key)
	return rng
