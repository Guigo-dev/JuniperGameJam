extends Control


func _ready() -> void:
	atualizar_labels()

func _process(delta: float) -> void:
	if(GameManager.XP == 0):
		$GunButton/LifeStatButton.disabled = true
		$GunButton/VelStatButton.disabled = true
		$GunButton/FireRateButton.disabled = true
		
		$BulletButton/PenStatButton.disabled = true
		$BulletButton/BulletVelStatButton.disabled = true
		$BulletButton/DamageButton.disabled = true

func atualizar_labels():
	$GunButton/LifeStatButton/Level.text = "Level: " +str(GameManager.gunStats["lifeUpgradeQtd"])
	$GunButton/VelStatButton/Level.text = "Level: " +str(GameManager.gunStats["speedUpgradeQtd"])
	$GunButton/FireRateButton/Level.text = "Level: " +str(GameManager.gunStats["fire_rateUpgradeQtd"])
	
	$BulletButton/PenStatButton/Level.text = "Level: " +str(GameManager.bulletStat["penetrationUpgradeQtd"])
	$BulletButton/BulletVelStatButton/Level.text = "Level: " +str(GameManager.bulletStat["velocityUpgradeQtd"])
	$BulletButton/DamageButton/Level.text = "Level: " +str(GameManager.bulletStat["damageUpgradeQtd"])
	
#emitindo sinais de upgrade de arma
func _on_life_stat_button_pressed() -> void:
	if(GameManager.gunStats["lifeUpgradeQtd"] == 2):
		$GunButton/LifeStatButton.disabled = true
	GameManager.gunStats["lifeUpgradeQtd"] += 1
	atualizar_labels()
	GameManager.XP -=1
	GameManager.gun_stat_changed.emit(GameManager.GunStat.life)

func _on_vel_stat_button_pressed() -> void:
	if(GameManager.gunStats["speedUpgradeQtd"] == 2):
		$GunButton/VelStatButton.disabled = true
	GameManager.gunStats["speedUpgradeQtd"] += 1
	atualizar_labels()
	GameManager.XP -=1
	GameManager.gun_stat_changed.emit(GameManager.GunStat.speed)

func _on_fire_rate_button_pressed() -> void:
	if(GameManager.gunStats["fire_rateUpgradeQtd"] == 2):
		$GunButton/FireRateButton.disabled = true
	GameManager.gunStats["fire_rateUpgradeQtd"] += 1
	atualizar_labels()
	GameManager.XP -=1
	GameManager.gun_stat_changed.emit(GameManager.GunStat.fire_rate)


#emitindo sinais de upgrade de bala
func _on_pen_stat_button_pressed() -> void:
	if(GameManager.bulletStat["penetrationUpgradeQtd"] == 2):
		$BulletButton/PenStatButton.disabled = true
	GameManager.bulletStat["penetrationUpgradeQtd"] += 1
	GameManager.XP -=1
	atualizar_labels()
	GameManager.bullet_stat_changed.emit(GameManager.BulletStat.penetration)

func _on_bullet_vel_stat_button_pressed() -> void:
	if(GameManager.bulletStat["velocityUpgradeQtd"] == 2):
		$BulletButton/BulletVelStatButton.disabled = true
	GameManager.bulletStat["velocityUpgradeQtd"] += 1
	atualizar_labels()
	GameManager.XP -=1
	GameManager.bullet_stat_changed.emit(GameManager.BulletStat.velocity)

func _on_damage_button_pressed() -> void:
	if(GameManager.bulletStat["damageUpgradeQtd"] == 2):
		$BulletButton/DamageButton.disabled = true
	GameManager.bulletStat["damageUpgradeQtd"] += 1
	atualizar_labels()
	GameManager.XP -=1
	GameManager.bullet_stat_changed.emit(GameManager.BulletStat.damage)

func _on_try_again_button_pressed() -> void:
	GameManager._on_upgrades_finished()
