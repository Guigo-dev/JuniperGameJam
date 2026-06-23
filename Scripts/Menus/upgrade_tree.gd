extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#emitindo sinais de upgrade de arma
func _on_life_stat_button_pressed() -> void:
	if(GameManager.XP>0):
		GameManager.XP -=1
		GameManager.gun_stat_changed.emit(GameManager.GunStat.life)

func _on_vel_stat_button_pressed() -> void:
	if(GameManager.XP>0):
		GameManager.XP -=1
		GameManager.gun_stat_changed.emit(GameManager.GunStat.speed)

func _on_fire_rate_button_pressed() -> void:
	if(GameManager.XP>0):
		GameManager.XP -=1
		GameManager.gun_stat_changed.emit(GameManager.GunStat.fire_rate)


#emitindo sinais de upgrade de bala
func _on_pen_stat_button_pressed() -> void:
	if(GameManager.XP>0):
		GameManager.XP -=1
		GameManager.bullet_stat_changed.emit(GameManager.BulletStat.penetration)

func _on_bullet_vel_stat_button_pressed() -> void:
	if(GameManager.XP>0):
		GameManager.XP -=1
		GameManager.bullet_stat_changed.emit(GameManager.BulletStat.velocity)

func _on_damage_button_pressed() -> void:
	if(GameManager.XP>0):
		GameManager.XP -=1
		GameManager.bullet_stat_changed.emit(GameManager.BulletStat.damage)
