extends Area2D

@onready var healthComponent: HealthComponent = %HealthComponent

@export var speed : float
var target: Node2D

func _ready() -> void:
	add_to_group("enemy")
	print("spawnei")
	
func _process(delta):
	if target == null:
		return

	var direction = global_position.direction_to(target.global_position)
	global_position += direction * speed * delta
	
