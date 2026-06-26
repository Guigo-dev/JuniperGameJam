class_name BulletSpawner extends Node2D


@export var bala: PackedScene
@onready var arma: Node2D = get_parent()
@onready var cpu_particles_2d = $CPUParticles2D
@onready var gun_shot_sound = $gunShotSound

func defineInstanceLocal(modifier, bullet) -> void:
	if(modifier != null):
		if(modifier == "SpiralBullet"):
			get_parent().add_child(bullet)
	else:
		get_parent().get_parent().add_child(bullet)
func spawnBullet(modifier = null) -> void:
	var bullet = bala.instantiate()
	bullet.target = arma
	bullet.position = global_position
	bullet.global_rotation = arma.global_rotation-0.35 #esse -0.35 foi pra endireitar o angulo, sla pq esse valor
	get_parent().get_parent().add_child(bullet)
	cpu_particles_2d.emitting = true
	gun_shot_sound.play()
	
	
