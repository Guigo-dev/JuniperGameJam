extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var power1 : TextureButton = $HBoxContainer/Power1
@onready var power2 : TextureButton = $HBoxContainer/Power2
@onready var power3 : TextureButton = $HBoxContainer/Power3

var powerKey = 0
var shopSlots = 3

func _ready() -> void:
	for i in range(1,shopSlots+1):	
		var currentPower = GameManager.powers[getNextPower()]
		get_node("HBoxContainer/Power%s/Name" %i).text = currentPower["Name"]
		get_node("HBoxContainer/Power%s/Description"%i).text = currentPower["Des"]
		get_node("HBoxContainer/Power%s/Cost"%i).text = str(currentPower["Cost"])

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
		
func getNextPower():
	if GameManager.remainingPowersKeys.is_empty():
		GameManager.resetPool()
	powerKey = GameManager.remainingPowersKeys.pop_back()
	return powerKey	

func _on_power_1_pressed() -> void:
	pass # Replace with function body.

func _on_power_2_pressed() -> void:
	pass # Replace with function body.


func _on_power_3_pressed() -> void:
	pass # Replace with function body.
