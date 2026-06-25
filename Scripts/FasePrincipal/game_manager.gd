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


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Pause")):
		get_tree().paused = !get_tree().paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
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
