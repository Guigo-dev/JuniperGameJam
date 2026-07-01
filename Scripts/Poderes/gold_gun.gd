extends Node

func _ready() -> void:
	add_to_group("item")
	add_to_group("gun")
	updateGun()
	
func updateGun():
	var sprite = get_parent().get_parent().get_node("Sprite2D")
	var bulletSpawner = get_parent().get_parent().get_node("BulletSpawner")
	
	sprite.texture = load("res://Sprites/PNG/arma_gold.png")
	bulletSpawner.bala = load("res://Scenes/Poderes/bala_de_ouro.tscn")
