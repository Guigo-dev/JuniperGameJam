extends Node

signal gun_changed(new_gun)

@export var main_menu: PackedScene
@export var souls : int = 0
@export var current_gun : String = "default"
var waveCounter: int = 0
var remainingPowersKeys=[]



func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func _process(delta: float) -> void:
	if(Input.is_action_pressed("reset")):
		get_tree().change_scene_to_packed(main_menu)
		

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
func resetPool():
	remainingPowersKeys=powers.keys()
	remainingPowersKeys.shuffle()
