extends Area2D

@onready var healthComponent := %HealthComponent
@onready var bulletSpawner := %BulletSpawner
@onready var bulletCooldown := $Timer
var direction = 1


func _physics_process(delta: float) -> void:
	if(Input.is_action_pressed("Direita")):
		direction = 1
	elif(Input.is_action_pressed("Esquerda")):
		direction = -1
	rotate((PI/30)*direction)
	
	if(Input.is_action_just_pressed("atirar") && bulletCooldown.is_stopped()):
		bulletSpawner.spawnBullet()
		bulletCooldown.start(0.5)

func _on_health_component_died() -> void:
	get_tree().paused = true

func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		healthComponent.updateLP(-1)
	if(area.is_in_group("lifeGainer")):
		healthComponent.updateLP(1)
