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
	GameManager.gun_stat_changed.connect(_on_gun_stat_changed)
	speedMultiplier = GameManager.gunStats["speed"]
	updateMaxHealth(GameManager.gunStats["life"])
	bulletCooldown = GameManager.gunStats["fire_rate"]
	get_parent().update_lifeCounterIcon(healthComponent.lifePoints,0)

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
	GameManager._on_player_died()

func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("enemy")):
		healthComponent.updateLP(-1)
		get_parent().update_lifeCounterIcon(healthComponent.lifePoints,0)
	if(area.is_in_group("lifeGainer")):
		healthComponent.updateLP(1)
		get_parent().update_lifeCounterIcon(healthComponent.lifePoints,0)
		
	
func updateMaxHealth(amount: int):
	healthComponent.MAX_LIFE = amount
	healthComponent.updateLP(amount)

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
	
func _on_gun_stat_changed(stat_type: int):
	if(stat_type == GameManager.GunStat.life):
		GameManager.gunStats["life"] += 1
	elif(stat_type == GameManager.GunStat.speed):
		GameManager.gunStats["speed"] += 0.25
	elif(stat_type == GameManager.GunStat.fire_rate):
		GameManager.gunStats["fire_rate"] -= 0.25
