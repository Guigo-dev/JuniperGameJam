extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		area.speed -= 12

func _on_area_exited(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		area.speed += 12

func _on_duracao_timeout() -> void:
	queue_free()
