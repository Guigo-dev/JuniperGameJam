extends Area2D

@export var tick_time := 0.5
var enemies := {} # inimigo -> tempo acumulado

func _physics_process(delta):
	for enemy in enemies.keys():
		if !is_instance_valid(enemy):
			enemies.erase(enemy)
			continue

		enemies[enemy] += delta

		if enemies[enemy] >= tick_time:
			enemies[enemy] -= tick_time
			if enemy.healthComponent.lifePoints > 0:
				enemy.healthComponent.updateLP(-1)


func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		enemies[area] = 0.0

func _on_area_exited(area: Area2D) -> void:
	enemies.erase(area)

func _on_duracao_timeout() -> void:
	queue_free()
