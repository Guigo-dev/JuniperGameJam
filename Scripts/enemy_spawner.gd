extends Node2D


@export var enemyScene: PackedScene
@export var cooldown: float
@onready var timer = $Timer
@export var target: Node2D
signal enemy_died

func _ready() -> void:
	timer.wait_time = cooldown


func _on_timer_timeout() -> void:
	var enemy = enemyScene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = global_position
	enemy.target = target
	enemy.healthComponent.died.connect(on_enemy_died)
	
func on_enemy_died():
	enemy_died.emit()
