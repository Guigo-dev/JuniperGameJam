extends Node2D

@onready var soulsText := $Souls/SoulsText
@export var arma: Area2D
@onready var soulCounterIcon = $Souls/SoulCounterIcon
@export var lifeCounterIcon: AnimatedSprite2D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	if(GameManager.resets == 0):
		$UI/Tutorial.visible = true
		await get_tree().create_timer(3).timeout
		var tween = create_tween()
		tween.tween_property($UI/Tutorial, "modulate:a", 0.0, 1.0)
		await tween.finished
		$UI/Tutorial.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	soulsText.text = (var_to_str(GameManager.souls))
	

func updateGun(newGun:PackedScene) -> void:
	var novaArma = newGun.instantiate()
	add_child(novaArma)
	novaArma.global_transform = arma.global_transform
	arma.queue_free()
	arma = novaArma
	GameManager.gun_changed.emit(arma)

func _on_enemy_spawner_enemy_died() -> void:
	update_pontos(1)


func _on_enemy_spawner_2_enemy_died() -> void:
	update_pontos(1)


func _on_enemy_spawner_3_enemy_died() -> void:
	update_pontos(1)

	
func update_pontos(quantidade: int)-> void:
	soulCounterIcon.play("default")
	GameManager.souls +=quantidade
	
func update_lifeCounterIcon(life_amount: int, frame: int):
	var animationName = str(life_amount) + " life"
	lifeCounterIcon.play(animationName)
	if(frame != null):
		lifeCounterIcon.set_frame_and_progress(frame,0.0)
