extends Node

func _ready() -> void:
	updateGun()
	
func updateGun():
	var sprite = get_parent().get_node("Sprite2D")
	var bulletSpawner = get_parent().get_node("BulletSpawner")
	
	sprite.texture = load("res://Sprites/PNG/arma_fogo.png")
	bulletSpawner.bala = load("res://Scenes/Poderes/bala_de_fogo.tscn")
