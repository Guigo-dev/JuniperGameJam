extends Area2D

@onready var healthComponent := %HealthComponent


func _on_health_component_died() -> void:
	get_tree().paused = true

func _on_area_entered(area: Area2D) -> void:
	print("hited")
	if(area.is_in_group("enemy")):
		print("hited")
		healthComponent.updateLP(-1)
	if(area.is_in_group("lifeGainer")):
		healthComponent.updateLP(1)
