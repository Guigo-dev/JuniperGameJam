extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var power0 : TextureButton = $HBoxContainer/Power0
@onready var power1 : TextureButton = $HBoxContainer/Power1
@onready var power2 : TextureButton = $HBoxContainer/Power2

var powerKey = 0
var shopSlots = 3
var shopPowers = {}

func _ready() -> void:
	$InsufficientSouls.visible = false
	for i in range(0,shopSlots):	
		var currentPower = GameManager.powers[getNextPower()]
		shopPowers[i]=currentPower	
		get_node("HBoxContainer/Power%s/Name" %i).text = currentPower["Name"]
		get_node("HBoxContainer/Power%s/Description"%i).text = currentPower["Des"]
		get_node("HBoxContainer/Power%s/Cost"%i).text = str(currentPower["Cost"])
		

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
func _process(delta: float) -> void:
	btn_hovered(power0)
	btn_hovered(power1)
	btn_hovered(power2)

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
	
func buyItem(currentShopSlot: int):
	if GameManager.souls >= shopPowers[currentShopSlot]["Cost"]:
		GameManager.souls = GameManager.souls - shopPowers[currentShopSlot]["Cost"]
		print(GameManager.souls)
		if GameManager.inventory[0].is_empty() and !shopPowers[currentShopSlot]["Type"]=="Health":
			GameManager.inventory[0] = shopPowers[currentShopSlot]
			return
		if shopPowers[currentShopSlot]["Type"] == "Gun":
			for i in GameManager.inventory:
				if GameManager.inventory[i]["Type"] == "Gun":
					GameManager.inventory[i] = shopPowers[currentShopSlot]
					return
			GameManager.inventory[GameManager.inventory.size()]=shopPowers[currentShopSlot]
			return
		if shopPowers[currentShopSlot]["Type"] =="Trajectory":
			for i in GameManager.inventory:
				if GameManager.inventory[i]["Type"] == "Trajectory":
					GameManager.inventory[i] = shopPowers[currentShopSlot]
					return
			GameManager.inventory[GameManager.inventory.size()]=shopPowers[currentShopSlot]
			return
		if shopPowers[currentShopSlot]["Type"] =="Health":
			if GameManager.healthComponent:
				GameManager.healthComponent.updateLP(1)
				return
			else:
				push_warning("HealthComponent do player null")
				return
		else:
			GameManager.inventory[GameManager.inventory.size()]=shopPowers[currentShopSlot]
			return

func hasEnoughSouls(currentShopSlot):
	return GameManager.souls >= shopPowers[currentShopSlot]["Cost"]
	
func showInsufficientSouls():
	$InsufficientSouls.show()
	await get_tree().create_timer(1.5).timeout
	$InsufficientSouls.hide()

func _on_power_0_pressed() -> void:
	if !hasEnoughSouls(0):
		showInsufficientSouls()
		return
	buyItem(0)
	$HBoxContainer/Power0.disabled = true
	print(GameManager.inventory)
		

func _on_power_1_pressed() -> void:
	if !hasEnoughSouls(1):
		showInsufficientSouls()
		return
	buyItem(1)
	$HBoxContainer/Power1.disabled = true
	print(GameManager.inventory)

func _on_power_2_pressed() -> void:
	if !hasEnoughSouls(2):
		showInsufficientSouls()
		return
	buyItem(2)
	$HBoxContainer/Power2.disabled = true
	print(GameManager.inventory)
