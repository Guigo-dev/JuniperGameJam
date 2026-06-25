extends Node2D

@export var enemyScene: PackedScene
@export var target: Node2D

signal enemy_died
signal enemy_removed

func _on_enemy_removed():
	enemy_removed.emit()

func _ready() -> void:
	GameManager.gun_changed.connect(on_gun_changed)

func spawn_enemy():

	if enemyScene == null:
		return

	var enemy = enemyScene.instantiate()

	get_parent().add_child(enemy)

	enemy.global_position = global_position
	enemy.target = target

	enemy.healthComponent.died.connect(_on_enemy_died)
	enemy.tree_exited.connect(_on_enemy_removed)

func _on_enemy_died():
	enemy_died.emit()

func on_gun_changed(newGun):
	target = newGun
