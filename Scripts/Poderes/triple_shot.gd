extends Node

var bala : PackedScene = load("res://Scenes/FasePrincipal/Bala.tscn")

func _ready() -> void:
	print(bala)
	spawnTripleBullet()
func spawnTripleBullet():
	for i in 2:
		pass
	var bullet = bala.instantiate()
	print(bullet)
