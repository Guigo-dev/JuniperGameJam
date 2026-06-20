extends Node2D


@export var enemyScene: PackedScene
@export var cooldown: float
@onready var timer = $Timer
@export var target: Node2D

func _ready() -> void:
	timer.wait_time = cooldown

func _on_timer_timeout() -> void:
	var enemy = enemyScene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = global_position
	enemy.target = target
