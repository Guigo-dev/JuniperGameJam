extends Area2D

@onready var healthComponent: HealthComponent = %HealthComponent
@export var speed : float
@export var target: Node2D
@export var knockbackforce: int
@onready var sprite = $Sprite2D
@onready var hit_sound = $hitSound

func _ready() -> void:
	add_to_group("enemy")
	GameManager.gun_changed.connect(on_gun_changed)
	print(get_path())
	
func _process(delta):
	if target == null:
		return

	var direction = global_position.direction_to(target.global_position)
	global_position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("bala")):
		hit_sound.play() 
		healthComponent.updateLP(-1)
		flash_damage()
		var direction = (global_position - area.position).normalized()
		var tween = create_tween()
		tween.tween_property(
			self,
			"global_position",
			global_position + direction * knockbackforce,
			0.15
		)
	if(area.is_in_group("lifeGainer")):
		healthComponent.updateLP(1)
	if(area.is_in_group("arma")):
		queue_free()
		

func _on_health_component_died() -> void:
	speed = 0
	for i in range(3):
		sprite.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color.WHITE
		await get_tree().create_timer(0.1).timeout
	queue_free()

func on_gun_changed(newGun) -> void:
	target = newGun
	
func flash_damage():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE
