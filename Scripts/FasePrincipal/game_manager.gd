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


enum GunStat {life,speed,fire_rate} 
enum BulletStat {penetration, velocity, damage}
@export var main_menu: PackedScene
@export var upgrade_tree_scene : PackedScene
var current_upgrade_tree

var XP:= 1000;
var resets = 0;
var currentGunLife : int = 3

var souls : int = 1000
@export var current_gun : String = "default"
var waveCounter: int = 0
var maxWaveCounter: int = 0
var lastWave: int = -1
var remainingPowersKeys=[]
var inventoryUpdatedFlag := false

const SHOP_SCENE = "res://Scenes/Menus/shop.tscn"
const GAME_SCENE = preload("res://Scenes/FasePrincipal/FasePrincipal.tscn")


func changeSceneShop(): 
	get_tree().change_scene_to_file(SHOP_SCENE)
func changeSceneGame():
	get_tree().change_scene_to_packed(GAME_SCENE)


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _process(delta: float) -> void:
	pass
		
const RICOCHET_SCENE = preload("res://Scenes/Poderes/ricochet.tscn")
const TRIPLE_SHOT_SCENE = preload("res://Scenes/Poderes/triple_shot.tscn")
const LASER_AIM_SCENE = preload("res://Scenes/Poderes/laser_aim.tscn")
const AUTO_AIM_SCENE = preload("res://Scenes/Poderes/auto_aim.tscn")
const SPIRAL_BULLET_SCENE = preload("res://Scenes/Poderes/spiral_bullet.tscn")
const HIGH_NOON_SCENE = preload("res://Scenes/Poderes/high_noon.tscn")
const GOLD_GUN_SCENE = preload("res://Scenes/Poderes/gold_gun.tscn")
const ICE_GUN_SCENE = preload("res://Scenes/Poderes/ice_gun.tscn")
const FIRE_GUN_SCENE = preload("res://Scenes/Poderes/arma_de_fogo.tscn")

var inventory = {0:{}}
#Dicionário dos poderes
var powers =	{
	#0:{
		#"id": 0,
		#"Name": "Ricochet",
		#"Des": "Ricochet bullets",
		#"Cost": 10,
		#"Type": "Bullet Modifier",
		#"Scene": RICOCHET_SCENE
	#},
	#1:{
		#"id": 1,
		#"Name": "Triple Shot",
		#"Des": "Triple the fun",
		#"Cost": 20,
		#"Type": "Bullet Modifier",
		#"Scene": TRIPLE_SHOT_SCENE
	#},
	#2:{
		#"id": 2,
		#"Name": "Laser Aim",
		#"Des": "More precision",
		#"Cost": 25,
		#"Type": "Gun Modifier",
		#"Scene": LASER_AIM_SCENE
	#},
	#3:{
		#"id": 3,
		#"Name": "Auto-aim",
		#"Des": "Literal Aimbot",
		#"Cost": 40,
		#"Type": "Trajectory",
		#"Scene": AUTO_AIM_SCENE
	#},
	#4:{
		#"id": 4,
		#"Name": "Spiral Bullet",
		#"Des": "Bullets can curve??",
		#"Cost": 15,
		#"Type": "Trajectory",
		#"Scene": SPIRAL_BULLET_SCENE
	#},
	0:{
		"id": 0,
		"Name": "Heal",
		"Des": "More HP",
		"Cost": 10,
		"Type": "Health",
		"Scene": null
	},
	#6:{
		#"id": 6,
		#"Name": "High Noon",
		#"Des": "Everything dies",
		#"Cost": 30,
		#"Type": "Power",
		#"Scene": HIGH_NOON_SCENE
	#},
	1:{
		"id": 1,
		"Name": "Gold Gun",
		"Des": "MONEY",
		"Cost": 20,
		"Type": "Gun",
		"Scene": GOLD_GUN_SCENE
	},
	2:{
		"id": 2,
		"Name": "Fire Gun",
		"Des": "Fireball",
		"Cost": 20,
		"Type": "Gun",
		"Scene": FIRE_GUN_SCENE
	},
	3:{
		"id": 3,
		"Name": "Ice Gun",
		"Des": "Achooo!",
		"Cost": 20,
		"Type": "Gun",
		"Scene": ICE_GUN_SCENE
	},
}
#Reseta a pool de poderes
func resetPool():
	remainingPowersKeys=powers.keys()
	if !inventory[0].is_empty():
		for i in inventory:
			for j in remainingPowersKeys:
				if int(inventory[i]["id"]) == remainingPowersKeys[j]:
					remainingPowersKeys.remove_at(j)
	remainingPowersKeys.shuffle()
	
func isInventoryUpdated():
	inventoryUpdatedFlag = true
	
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
	souls = 1000
	inventory = {0:{}}
	resetPool()
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
