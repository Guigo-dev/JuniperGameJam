extends Control


func _ready() -> void:
	atualizar_labels()


func atualizar_labels():
	$GunButton/LifeStatButton/Level.text = "Level: " +str(GameManager.gunStats["lifeUpgradeQtd"])
	$GunButton/VelStatButton/Level.text = "Level: " +str(GameManager.gunStats["speedUpgradeQtd"])
	$GunButton/FireRateButton/Level.text = "Level: " +str(GameManager.gunStats["fire_rateUpgradeQtd"])
	
	$BulletButton/PenStatButton/Level.text = "Level: " +str(GameManager.bulletStat["penetrationUpgradeQtd"])
	$BulletButton/BulletVelStatButton/Level.text = "Level: " +str(GameManager.bulletStat["velocityUpgradeQtd"])
	$BulletButton/DamageButton/Level.text = "Level: " +str(GameManager.bulletStat["damageUpgradeQtd"])
	
#emitindo sinais de upgrade de arma
func _on_life_stat_button_pressed() -> void:
	if(GameManager.gunStats["lifeUpgradeQtd"] < 3):
		if(GameManager.XP>0):
			GameManager.gunStats["lifeUpgradeQtd"] += 1
			atualizar_labels()
			GameManager.XP -=1
			GameManager.gun_stat_changed.emit(GameManager.GunStat.life)

func _on_vel_stat_button_pressed() -> void:
	if(GameManager.gunStats["speedUpgradeQtd"] < 3):
		if(GameManager.XP>0):
			GameManager.gunStats["speedUpgradeQtd"] += 1
			atualizar_labels()
			GameManager.XP -=1
			GameManager.gun_stat_changed.emit(GameManager.GunStat.speed)

func _on_fire_rate_button_pressed() -> void:
	if(GameManager.gunStats["fire_rateUpgradeQtd"] < 3):
		if(GameManager.XP>0):
			GameManager.gunStats["fire_rateUpgradeQtd"] += 1
			atualizar_labels()
			GameManager.XP -=1
			GameManager.gun_stat_changed.emit(GameManager.GunStat.fire_rate)


#emitindo sinais de upgrade de bala
func _on_pen_stat_button_pressed() -> void:
	if(GameManager.bulletStat["penetrationUpgradeQtd"] < 3):
		if(GameManager.XP>0):
			GameManager.bulletStat["penetrationUpgradeQtd"] += 1
			GameManager.XP -=1
			atualizar_labels()
			GameManager.bullet_stat_changed.emit(GameManager.BulletStat.penetration)

func _on_bullet_vel_stat_button_pressed() -> void:
	if(GameManager.bulletStat["velocityUpgradeQtd"] <3):
		if(GameManager.XP>0):
			GameManager.bulletStat["velocityUpgradeQtd"] += 1
			atualizar_labels()
			GameManager.XP -=1
			GameManager.bullet_stat_changed.emit(GameManager.BulletStat.velocity)

func _on_damage_button_pressed() -> void:
	if(GameManager.bulletStat["damageUpgradeQtd"] <3):
		if(GameManager.XP>0):
			GameManager.bulletStat["damageUpgradeQtd"] += 1
			atualizar_labels()
			GameManager.XP -=1
			GameManager.bullet_stat_changed.emit(GameManager.BulletStat.damage)


func _on_back_button_pressed() -> void:
	GameManager._on_upgrades_finished()
	
