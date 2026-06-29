extends Area2D

var direction
@export var speed = 70
@export var penetration = 1
@export var damage := 1
@export var target: Node2D
@export var pocoGelo: PackedScene
var maxpen : int

func _ready() -> void:
	add_to_group("bala")
	direction = global_position.direction_to(target.global_position)
	speed = GameManager.bulletStat["velocity"]
	penetration = GameManager.bulletStat["penetration"]
	damage = GameManager.bulletStat["damage"]
	maxpen = penetration
	
func _process(delta: float) -> void:
	global_position += direction * speed * delta * -1
	
func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		if maxpen == penetration:
			var poco = pocoGelo.instantiate()
			poco.global_position = global_position
			get_parent().get_parent().add_child(poco)
			
		penetration -= 1
		if(penetration <= 0):
			queue_free()
		
		
