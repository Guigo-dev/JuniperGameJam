extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var poder1 : TextureButton = $HBoxContainer/Poder1
@onready var poder2 : TextureButton = $HBoxContainer/Poder2
@onready var poder3 : TextureButton = $HBoxContainer/Poder3

func _process(delta: float) -> void:
	btn_hovered(poder1)
	btn_hovered(poder2)
	btn_hovered(poder3)

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
	
func 	btn_hovered(button: TextureButton):
	button.pivot_offset = button.size/2
	if button.is_hovered():
		start_tween(button,"scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button,"scale", Vector2.ONE, tween_duration)
