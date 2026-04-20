class_name seedManager
extends Node

var seed: int = 0
var rng := RandomNumberGenerator.new()

func set_seed(new_seed: int):
	seed = new_seed
	rng.seed = seed

func randf():
	return rng.randf()

func randi():
	return rng.randi()

func randf_range(a, b):
	return rng.randf_range(a, b)
