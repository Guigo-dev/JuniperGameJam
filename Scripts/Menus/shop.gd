extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var buttons :=[
	$HBoxContainer/Power0,
	$HBoxContainer/Power1,
	$HBoxContainer/Power2
]

var powerKey = 0
var shopSlots = 3
var shopPowers = {}

signal powerUpBuyed(powerUpType)

func _ready() -> void:
	updateSouls()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	for button in buttons:
		button.mouse_entered.connect(_on_button_mouse_entered.bind(button))
		button.mouse_exited.connect(_on_button_mouse_exited.bind(button))
		button.pressed.connect(_on_button_pressed.bind(button))
	for i in range(0,shopSlots):	
		var currentPower = GameManager.powers[getNextPower()]
		shopPowers[i]=currentPower	
		get_node("HBoxContainer/Power%s/Name" %i).text = currentPower["Name"]
		get_node("HBoxContainer/Power%s/Description"%i).text = currentPower["Des"]
		get_node("HBoxContainer/Power%s/Cost"%i).text = str(currentPower["Cost"])
		


func _process(delta: float) -> void:
	pass

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
	
func btn_hovered(button: TextureButton):
	button.pivot_offset = button.size/2
	if button.is_hovered():
		start_tween(button,"scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button,"scale", Vector2.ONE, tween_duration)

func _on_button_mouse_entered(button: TextureButton) -> void:
	print(button)
	if button.disabled:
		return
	button.pivot_offset = button.size / 2
	start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	
func _on_button_mouse_exited(button: TextureButton) -> void:
	start_tween(button, "scale", Vector2.ONE, tween_duration)

		
func getNextPower():
	if GameManager.remainingPowersKeys.is_empty():
		GameManager.resetPool()
	powerKey = GameManager.remainingPowersKeys.pop_back()
	return powerKey
	
func buyItem(currentShopSlot: int):
	if GameManager.souls >= shopPowers[currentShopSlot]["Cost"]:
		print(shopPowers[currentShopSlot]["Name"])
		GameManager.souls = GameManager.souls - shopPowers[currentShopSlot]["Cost"]
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

func hasEnoughSouls(button: TextureButton):
	return GameManager.souls >= int(button.get_node("Cost").text)
	
func showInsufficientSouls():
	$InsufficientSouls.show()
	await get_tree().create_timer(1.5).timeout
	$InsufficientSouls.hide()

func showPowerPurchasedMessage(button: TextureButton):
	get_node("PowerPurchasedMessage").text = button.get_node("Name").text + " has been purchased"
	$PowerPurchasedMessage.show()
	await get_tree().create_timer(1.5).timeout
	$PowerPurchasedMessage.hide()

func updateSouls():
	get_node("SoulsText").text = str(GameManager.souls)

func _on_button_pressed(button: TextureButton) -> void:
	var currentItemSlot =  int(button.name.trim_prefix("Power"))
	if !hasEnoughSouls(button):
		showInsufficientSouls()
		return
	buyItem(currentItemSlot)
	showPowerPurchasedMessage(button)
	updateSouls()
	button.disabled = true

func _on_continue_next_wave_pressed() -> void:
	GameManager.changeSceneGame()
