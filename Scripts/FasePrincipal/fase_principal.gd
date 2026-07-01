extends Node2D

@onready var soulsText := $Souls/SoulsText
@export var arma: Area2D
@onready var soulCounterIcon = $Souls/SoulCounterIcon
@export var lifeCounterIcon: AnimatedSprite2D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	GameManager.fade_in($Fade)
	showCurrentWave()
	showTutorial()
	

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Pause")):
		$UI/Pause.visible = true
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	soulsText.text = (var_to_str(GameManager.souls))
	
func showCurrentWave():
	$UI/Wave/WaveCounter.text = str(GameManager.waveCounter)
	$UI/Wave.modulate.a = 0.0
	await get_tree().create_timer(1).timeout
	start_tween($UI/Wave, "modulate:a", 1.0, 1.5)
	await get_tree().create_timer(3).timeout
	start_tween($UI/Wave, "modulate:a", 0.0, 2.5)
	#$UI/Wave.visible = false;

func showTutorial():
	$UI/Tutorial.modulate.a = 0.0
	if(GameManager.resets == 0 && GameManager.waveCounter == 1):
		await get_tree().create_timer(1).timeout
		start_tween($UI/Tutorial, "modulate:a", 1.0, 1.0)
		await get_tree().create_timer(3).timeout
		start_tween($UI/Tutorial, "modulate:a", 0.0, 3.0)

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

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


func _on_continue_bt_pressed() -> void:
	get_tree().paused = false
	$UI/Pause.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
