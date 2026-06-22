extends Area2D

@onready var healthComponent := %HealthComponent
@onready var bulletSpawner := %BulletSpawner
@onready var bulletCooldownTimer := $BulletCooldown

@export var bulletCooldown: float
@export var speedMultiplier := 1.0

@export_range(0.0,100.0) var spring: float
@export_range(0.0,100.0) var damp: float

var juicyVelocity = 0
var force
var juicyDisplacement = 0

var speed
var direction = 1


func _ready() -> void:
	add_to_group("arma")

func _physics_process(delta: float) -> void:
	speed = 75 * speedMultiplier #velocidade base de rotacao
	if(Input.is_action_pressed("Direita")):
		direction = 1
		speed = 65 * speedMultiplier
	elif(Input.is_action_pressed("Esquerda")):
		direction = -1
		speed = 65 * speedMultiplier
	rotate((PI/speed)*direction)
	
	if(Input.is_action_just_pressed("atirar") && bulletCooldownTimer.is_stopped()):
		bulletSpawner.spawnBullet()
		bulletCooldownTimer.start(bulletCooldown)
		juicyVelocity = 30
	shake(delta)

func _on_health_component_died() -> void:
	get_tree().paused = true

func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		print("acertou")
		healthComponent.updateLP(-1)
	if(area.is_in_group("lifeGainer")):
		healthComponent.updateLP(1)
		
func updateMaxHealth(amount: int):
	healthComponent.MAX_LIFE += amount

func updateSpeedMultiplier(amount: float):
	speedMultiplier = amount
	
func shake(delta:float) -> void:
	force = -spring * juicyDisplacement - damp*juicyVelocity
	juicyVelocity += force * delta
	juicyDisplacement += juicyVelocity * delta
	scale = Vector2(
		1.0 + juicyDisplacement,
		1.0 - juicyDisplacement
	)
	
