extends Area2D

@onready var healthComponent: HealthComponent = %HealthComponent
@export var speed : float
var target: Node2D

func _ready() -> void:
	add_to_group("enemy")
	
func _process(delta):
	if target == null:
		return

	var direction = global_position.direction_to(target.global_position)
	global_position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("bala")):
		healthComponent.updateLP(-1)
	if(area.is_in_group("lifeGainer")):
		healthComponent.updateLP(1)
	if(area.is_in_group("arma")):
		healthComponent.updateLP(1)
		queue_free()
		


func _on_health_component_died() -> void:
	queue_free()
