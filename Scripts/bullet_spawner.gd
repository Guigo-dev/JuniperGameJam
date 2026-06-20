class_name BulletSpawner extends Node2D


@export var bala: PackedScene
@onready var arma: Node2D = $".."

func spawnBullet() -> void:
	var bullet = bala.instantiate()
	bullet.target = arma
	bullet.position = global_position
	get_parent().get_parent().add_child(bullet)
	
	
