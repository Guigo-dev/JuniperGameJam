extends Node

const RICOCHET_SCENE = preload("res://Scenes/Poderes/ricochet.tscn")
const TRIPLE_SHOT_SCENE = preload("res://Scenes/Poderes/triple_shot.tscn")
const LASER_AIM_SCENE = preload("res://Scenes/Poderes/laser_aim.tscn")
const AUTO_AIM_SCENE = preload("res://Scenes/Poderes/auto_aim.tscn")
const SPIRAL_BULLET_SCENE = preload("res://Scenes/Poderes/spiral_bullet.tscn")
const HIGH_NOON_SCENE = preload("res://Scenes/Poderes/high_noon.tscn")
const GOLD_GUN_SCENE = preload("res://Scenes/Poderes/gold_gun.tscn")
const ICE_GUN_SCENE = preload("res://Scenes/Poderes/ice_gun.tscn")
const FIRE_GUN_SCENE = preload("res://Scenes/Poderes/arma_de_fogo.tscn")

var remainingPowersKeys=[]
var inventory = {0:{}}
var inventoryUpdatedFlag := false
#enum Type {BULLET_MODIFIER,TRAJECTORY,GUN_MODIFIER,GUN,HEALTH}
const BULLET_MODIFIER = "bullet_modifier"
const TRAJECTORY = "trajectory"
const GUN_MODIFIER = "gun_modifier"
const GUN = "gun"
const HEALTH = "health"
const POWER = "power"

const EXCLUSIVE_ITEMS = [GUN, TRAJECTORY]

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
		"Type": HEALTH,
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
		"Type": GUN,
		"Scene": GOLD_GUN_SCENE
	},
	2:{
		"id": 2,
		"Name": "Fire Gun",
		"Des": "Fireball",
		"Cost": 20,
		"Type": GUN,
		"Scene": FIRE_GUN_SCENE
	},
	3:{
		"id": 3,
		"Name": "Ice Gun",
		"Des": "Achooo!",
		"Cost": 20,
		"Type": GUN,
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
