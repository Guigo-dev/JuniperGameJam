extends Control


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	atualizar_labels()
	GameManager.waveCounter=0
	await GameManager.fade_in(get_parent().get_parent().get_node("%Fade"))

func _process(delta: float) -> void:
	$XpRect/XPQtdLabel.text = str(GameManager.XP)
	if(GameManager.XP == 0):
		$GunButton/LifeStatButton.disabled = true
		$GunButton/VelStatButton.disabled = true
		$GunButton/FireRateButton.disabled = true
		
		$BulletButton/PenStatButton.disabled = true
		$BulletButton/BulletVelStatButton.disabled = true
		$BulletButton/DamageButton.disabled = true

func atualizar_labels():
	if(GameManager.gunStats["lifeUpgradeQtd"] == 3):
		$GunButton/LifeStatButton.disabled = true
	if(GameManager.gunStats["speedUpgradeQtd"] == 3):
		$GunButton/VelStatButton.disabled = true
	if(GameManager.gunStats["fire_rateUpgradeQtd"] == 3):
		$GunButton/FireRateButton.disabled = true
	if(GameManager.bulletStat["penetrationUpgradeQtd"] == 3):
		$BulletButton/PenStatButton.disabled = true
	if(GameManager.bulletStat["velocityUpgradeQtd"] == 3):
		$BulletButton/BulletVelStatButton.disabled = true
	if(GameManager.bulletStat["damageUpgradeQtd"] == 3):
		$BulletButton/DamageButton.disabled = true
	$GunButton/LifeStatButton/Level.text = str(GameManager.gunStats["lifeUpgradeQtd"])
	$GunButton/VelStatButton/Level.text = str(GameManager.gunStats["speedUpgradeQtd"])
	$GunButton/FireRateButton/Level.text = str(GameManager.gunStats["fire_rateUpgradeQtd"])
	
	$BulletButton/PenStatButton/Level.text = str(GameManager.bulletStat["penetrationUpgradeQtd"])
	$BulletButton/BulletVelStatButton/Level.text = str(GameManager.bulletStat["velocityUpgradeQtd"])
	$BulletButton/DamageButton/Level.text = str(GameManager.bulletStat["damageUpgradeQtd"])
	
#emitindo sinais de upgrade de arma
func _on_life_stat_button_pressed() -> void:
	GameManager.gunStats["lifeUpgradeQtd"] += 1
	atualizar_labels()
	GameManager.XP -=1
	GameManager.gun_stat_changed.emit(GameManager.GunStat.life)

func _on_vel_stat_button_pressed() -> void:
	GameManager.gunStats["speedUpgradeQtd"] += 1
	atualizar_labels()
	GameManager.XP -=1
	GameManager.gun_stat_changed.emit(GameManager.GunStat.speed)

func _on_fire_rate_button_pressed() -> void:
	GameManager.gunStats["fire_rateUpgradeQtd"] += 1
	atualizar_labels()
	GameManager.XP -=1
	GameManager.gun_stat_changed.emit(GameManager.GunStat.fire_rate)


#emitindo sinais de upgrade de bala
func _on_pen_stat_button_pressed() -> void:
	GameManager.bulletStat["penetrationUpgradeQtd"] += 1
	GameManager.XP -=1
	atualizar_labels()
	GameManager.bullet_stat_changed.emit(GameManager.BulletStat.penetration)

func _on_bullet_vel_stat_button_pressed() -> void:
	GameManager.bulletStat["velocityUpgradeQtd"] += 1
	atualizar_labels()
	GameManager.XP -=1
	GameManager.bullet_stat_changed.emit(GameManager.BulletStat.velocity)

func _on_damage_button_pressed() -> void:
	GameManager.bulletStat["damageUpgradeQtd"] += 1
	atualizar_labels()
	GameManager.XP -=1
	GameManager.bullet_stat_changed.emit(GameManager.BulletStat.damage)

func _on_try_again_button_pressed() -> void:
	GameManager._on_upgrades_finished()
