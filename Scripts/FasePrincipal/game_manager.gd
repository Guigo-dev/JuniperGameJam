extends Node


signal gun_changed(new_gun)
signal gun_stat_changed(stat: int)
signal bullet_stat_changed(stat: int)

enum GunStat {life,speed,fire_rate} 
enum BulletStat {penetration, velocity, damage}
@export var main_menu: PackedScene
var XP: int;

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func _process(delta: float) -> void:
	if(Input.is_action_pressed("reset")):
		get_tree().change_scene_to_packed(main_menu)
		
