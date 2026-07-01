extends Area2D
class_name Bala

var direction
@export var speed = 70
@export var penetration = 1
@export var damage := 1
@export var target: Node2D
var maxpen : int
enum GunType {FIRE,ICE,GOLD}

func _ready() -> void:
	add_to_group("bala")
	get_bullet_stats()

func get_bullet_stats():
	direction = global_position.direction_to(target.global_position)
	speed = GameManager.bulletStat["velocity"]
	penetration = GameManager.bulletStat["penetration"]
	damage = GameManager.bulletStat["damage"]
	maxpen = penetration
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * speed * delta * -1	
	if(penetration <= 0 || global_position.x > 300 || global_position.x < -300
						|| global_position.y < -180 || global_position.y > 165 ):
		queue_free()

	
func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		apply_effects()
		penetration -= 1
		if(penetration <= 0):
			queue_free()

func apply_effects():
	pass
