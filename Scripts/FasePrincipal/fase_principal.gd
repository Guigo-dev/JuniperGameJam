extends Node2D

@onready var pontosText := $Pontos/TextPontos
@export var arma: Area2D

var pontos := 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pontosText.text = (var_to_str(pontos))

func updateGun(newGun:PackedScene) -> void:
	var novaArma = newGun.instantiate()
	add_child(novaArma)
	novaArma.global_transform = arma.global_transform
	arma.queue_free()
	arma = novaArma
	GameManager.gun_changed.emit(arma)

func _on_enemy_spawner_enemy_died() -> void:
	pontos += 1


func _on_enemy_spawner_2_enemy_died() -> void:
	pontos += 1


func _on_enemy_spawner_3_enemy_died() -> void:
	pontos += 1
