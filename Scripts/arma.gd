extends Area2D

@onready var healthComponent := %HealthComponent
@onready var bulletSpawner := %BulletSpawner
@onready var bulletCooldown := $Timer
var direction = 1

func _ready() -> void:
	add_to_group("arma")

func _physics_process(delta: float) -> void:
	var speed := 35
	if(Input.is_action_pressed("Direita")):
		direction = 1
		speed = 25
	elif(Input.is_action_pressed("Esquerda")):
		direction = -1
		speed = 25
	rotate((PI/speed)*direction)
	
	if(Input.is_action_just_pressed("atirar") && bulletCooldown.is_stopped()):
		bulletSpawner.spawnBullet()
		bulletCooldown.start(0.5)

func _on_health_component_died() -> void:
	get_tree().paused = true

func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		print("acertou")
		healthComponent.updateLP(-1)
	if(area.is_in_group("lifeGainer")):
		healthComponent.updateLP(1)
