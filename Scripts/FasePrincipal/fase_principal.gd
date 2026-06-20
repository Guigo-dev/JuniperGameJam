extends Node2D

@onready var pontosText := $Pontos/TextPontos
var pontos := 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pontosText.text = (var_to_str(pontos))
	if(Input.is_action_pressed("reset")):
		get_tree().reload_current_scene()


func _on_enemy_spawner_enemy_died() -> void:
	pontos += 1


func _on_enemy_spawner_2_enemy_died() -> void:
	pontos += 1


func _on_enemy_spawner_3_enemy_died() -> void:
	pontos += 1
