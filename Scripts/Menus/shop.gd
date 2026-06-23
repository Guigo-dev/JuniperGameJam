extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var power1 : TextureButton = $HBoxContainer/Power1
@onready var power2 : TextureButton = $HBoxContainer/Power2
@onready var power3 : TextureButton = $HBoxContainer/Power3

func _process(delta: float) -> void:
	btn_hovered(power1)
	btn_hovered(power2)
	btn_hovered(power3)

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
	
func 	btn_hovered(button: TextureButton):
	button.pivot_offset = button.size/2
	if button.is_hovered():
		start_tween(button,"scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button,"scale", Vector2.ONE, tween_duration)
