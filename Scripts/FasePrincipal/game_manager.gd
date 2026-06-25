extends Node

signal gun_changed(new_gun)
signal gun_stat_changed(stat: int)
signal bullet_stat_changed(stat: int)

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

@export var souls : int = 0
@export var current_gun : String = "default"
var waveCounter: int = 0
var remainingPowersKeys=[]



func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func _process(delta: float) -> void:
	if(Input.is_action_pressed("reset")):
		get_tree().change_scene_to_packed(main_menu)
		

#Dicionário dos poderes
@export var powers =	{
	0:{
		"Name": "Ricochet",
		"Des": "Ricochet bullets",
		"Cost": 10
	},
	1:{
		"Name": "Triple Shot",
		"Des": "Triple the fun",
		"Cost": 20
	},
	2:{
		"Name": "Laser Aim",
		"Des": "More precision",
		"Cost": 30
	},
	3:{
		"Name": "Auto-aim",
		"Des": "Literal Aimbot",
		"Cost": 40
	},
	4:{
		"Name": "Spiral Bullet",
		"Des": "Bullets can curve??",
		"Cost": 50
	},
	5:{
		"Name": "Heal",
		"Des": "More HP",
		"Cost": 60
	},
	6:{
		"Name": "High Noon",
		"Des": "Everything dies",
		"Cost": 70
	},
	7:{
		"Name": "Gold Gun",
		"Des": "MONEY",
		"Cost": 80
	},
	8:{
		"Name": "Fire Gun",
		"Des": "Fireball",
		"Cost": 90
	},
	9:{
		"Name": "Ice Gun",
		"Des": "Achooo!",
		"Cost": 100
	},
}
#Reseta a pool de poderes
func resetPool():
	remainingPowersKeys=powers.keys()
	remainingPowersKeys.shuffle()
	
var inventario = {}

func _on_player_died():
	get_tree().paused = true
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
