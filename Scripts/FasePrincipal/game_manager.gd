extends Node

signal gun_changed(new_gun)

@export var main_menu: PackedScene

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func _process(delta: float) -> void:
	if(Input.is_action_pressed("reset")):
		get_tree().change_scene_to_packed(main_menu)
		
