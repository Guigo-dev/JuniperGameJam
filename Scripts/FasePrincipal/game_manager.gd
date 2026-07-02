extends Node

signal gun_changed(new_gun)
signal gun_stat_changed(stat: int)
signal bullet_stat_changed(stat: int)
signal inventoryUpdated

var gunStats := {
	"life": 3,
	"speed": 0.85,
	"fire_rate": 0.75,
	"lifeUpgradeQtd": 0,
	"speedUpgradeQtd": 0,
	"fire_rateUpgradeQtd": 0
}
var bulletStat := {
	"penetration": 1,
	"velocity": 70,
	"damage": 1,
	"penetrationUpgradeQtd": 0,
	"velocityUpgradeQtd": 0,
	"damageUpgradeQtd": 0
}


enum GunStat {LIFE,SPEED,FIRE_RATE} 
enum BulletStat {PENETRATION, VELOCITY, DAMAGE}
@export var main_menu: PackedScene
@export var upgrade_tree_scene : PackedScene
var current_upgrade_tree

var XP:= 0;
var resets = 0;
var currentGunLife : int = 3

var souls : int = 1000
@export var current_gun : String = "default"
var waveCounter: int = 0
var maxWaveCounter: int = 0
var lastWave: int = -1



const SHOP_SCENE = "res://Scenes/Menus/shop.tscn"
const GAME_SCENE = preload("res://Scenes/FasePrincipal/FasePrincipal.tscn")

func changeSceneShop(): 
	get_tree().change_scene_to_file(SHOP_SCENE)
func changeSceneGame():
	get_tree().change_scene_to_packed(GAME_SCENE)


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_player_died():
	get_tree().paused = true
	var fade = get_tree().current_scene.get_node("%Fade")
	fade_out(fade)
	current_upgrade_tree = upgrade_tree_scene.instantiate()
	get_tree().current_scene.get_node("UI").add_child(current_upgrade_tree)

func _on_upgrades_finished():
	current_upgrade_tree.queue_free()
	restart_game()
	
func restart_game():
	resets += 1
	get_tree().paused = false
	souls = 0
	ItemManager.inventory = {0:{}}
	ItemManager.resetPool()
	get_tree().reload_current_scene()
	
func fade_in(preto: ColorRect, time:= 1.0):
	preto.visible = true
	preto.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(preto, "modulate:a", 0.0, time)
	await tween.finished
	preto.visible = false
	
func fade_out(preto: ColorRect, time := 1.0):
	preto.visible = true
	preto.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(preto, "modulate:a", 1.0, time)
	await tween.finished
	preto.visible = false
	
func incrementXp():
	if waveCounter > maxWaveCounter:
		maxWaveCounter = waveCounter
		XP +=1

func bulletStatChange(stat_type: int):
	if(stat_type == BulletStat.PENETRATION):
		bulletStat["penetration"] += 1
	elif(stat_type == BulletStat.VELOCITY):
		bulletStat["velocity"] += 7
	elif(stat_type == BulletStat.DAMAGE):
		bulletStat["damage"] += 1
		
func gunStatChange(stat_type: int):
	if(stat_type == GameManager.GunStat.LIFE):
		GameManager.gunStats["life"] += 1
		get_tree().current_scene.get_node("Arma/HealthComponent").updateLP(GameManager.gunStats["life"])
		GameManager.currentGunLife = get_tree().current_scene.get_node("Arma/HealthComponent").lifePoints
	elif(stat_type == GameManager.GunStat.SPEED):
		GameManager.gunStats["speed"] -= 0.15
	elif(stat_type == GameManager.GunStat.FIRE_RATE):
		GameManager.gunStats["fire_rate"] -= 0.25
