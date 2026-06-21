extends Area2D

var direction
@export var speed = 30
@export var penetration = 1
@export var dano := 1

var target: Node2D


func _ready() -> void:
	add_to_group("bala")
	direction = global_position.direction_to(target.global_position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * speed * delta * -1
	if(penetration == 0):
		free()
	
func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		penetration -= 1
