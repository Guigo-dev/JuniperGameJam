extends Area2D

var direction
var speed = 30
var target: Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = global_position.direction_to(target.global_position)
	global_position += direction * speed * delta * -1

func _ready() -> void:
	add_to_group("bala")
