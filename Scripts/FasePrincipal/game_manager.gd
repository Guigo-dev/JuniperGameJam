extends Node

signal gun_changed(new_gun)
signal gun_stat_changed(stat: int)
signal bullet_stat_changed(stat: int)
signal powerUpBuyed(powerUpType)

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

var XP:= 100;
var resets = 0;
var healthComponent : Node

var souls : int = 1000
@export var current_gun : String = "default"
var waveCounter: int = 0
var remainingPowersKeys=[]

const SHOP_SCENE = "res://Scenes/Menus/shop.tscn"
const GAME_SCENE = "res://Scenes/FasePrincipal/FasePrincipal.tscn"

func changeSceneShop(): 
	get_tree().change_scene_to_file(SHOP_SCENE)
func changeSceneGame():
	get_tree().change_scene_to_file(GAME_SCENE)


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Pause")):
		get_tree().paused = !get_tree().paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		

var inventory = {0:{}}
#Dicionário dos poderes
var powers =	{
	0:{
		"id": 0,
		"Name": "Ricochet",
		"Des": "Ricochet bullets",
		"Cost": 10,
		"Type": "Modifier"
	},
	1:{
		"id": 1,
		"Name": "Triple Shot",
		"Des": "Triple the fun",
		"Cost": 20,
		"Type": "Modifier"
	},
	2:{
		"id": 2,
		"Name": "Laser Aim",
		"Des": "More precision",
		"Cost": 30,
		"Type": "Modifier"
	},
	3:{
		"id": 3,
		"Name": "Auto-aim",
		"Des": "Literal Aimbot",
		"Cost": 40,
		"Type": "Trajectory"
	},
	4:{
		"id": 4,
		"Name": "Spiral Bullet",
		"Des": "Bullets can curve??",
		"Cost": 50,
		"Type": "Trajectory"
	},
	5:{
		"id": 5,
		"Name": "Heal",
		"Des": "More HP",
		"Cost": 60,
		"Type": "Health"
	},
	6:{
		"id": 6,
		"Name": "High Noon",
		"Des": "Everything dies",
		"Cost": 70,
		"Type": "Power"
	},
	7:{
		"id": 7,
		"Name": "Gold Gun",
		"Des": "MONEY",
		"Cost": 80,
		"Type": "Gun"
	},
	8:{
		"id": 8,
		"Name": "Fire Gun",
		"Des": "Fireball",
		"Cost": 90,
		"Type": "Gun"
	},
	9:{
		"id": 9,
		"Name": "Ice Gun",
		"Des": "Achooo!",
		"Cost": 100,
		"Type": "Gun"
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
