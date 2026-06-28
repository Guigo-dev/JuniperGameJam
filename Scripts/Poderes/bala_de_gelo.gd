extends Area2D

var direction
@export var speed = 70
@export var penetration = 1
@export var damage := 1
@export var target: Node2D
@export var pocoGelo: PackedScene


func _ready() -> void:
	add_to_group("bala")
	direction = global_position.direction_to(target.global_position)
	GameManager.bullet_stat_changed.connect(_on_bullet_stat_changed)
	speed = GameManager.bulletStat["velocity"]
	penetration = GameManager.bulletStat["penetration"]
	damage = GameManager.bulletStat["damage"]
	
func _process(delta: float) -> void:
	global_position += direction * speed * delta * -1
	if(penetration == 0):
		var poco = pocoGelo.instantiate()
		poco.global_position = global_position
		get_parent().get_parent().add_child(poco)
		
		queue_free()
	
func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		penetration -= 1

func _on_bullet_stat_changed(stat_type: int):
	if(stat_type == GameManager.BulletStat.penetration):
		GameManager.bulletStat["penetration"] += 1
	elif(stat_type == GameManager.BulletStat.velocity):
		GameManager.bulletStat["velocity"] += 5
	elif(stat_type == GameManager.BulletStat.damage):
		GameManager.bulletStat["damage"] += 1
