extends Node2D

@onready var pontosText := $Pontos/TextPontos
var pontos := 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pontosText.text = (var_to_str(pontos))


func _on_enemy_spawner_enemy_died() -> void:
	pontos += 1
