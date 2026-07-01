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


func _ready() -> void:
	updateSouls()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	for button in buttons:
		button.mouse_entered.connect(_on_button_mouse_entered.bind(button))
		button.mouse_exited.connect(_on_button_mouse_exited.bind(button))
		button.pressed.connect(_on_button_pressed.bind(button))
	for i in range(0,shopSlots):	
		var currentPower = ItemManager.powers[getNextPower()]
		shopPowers[i]=currentPower	
		get_node("HBoxContainer/Power%s/Name" %i).text = currentPower["Name"]
		get_node("HBoxContainer/Power%s/Description"%i).text = currentPower["Des"]
		get_node("HBoxContainer/Power%s/Cost"%i).text = str(currentPower["Cost"])
		

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
	
func _on_button_mouse_entered(button: TextureButton) -> void:
	if button.disabled:
		return
	button.pivot_offset = button.size / 2
	start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	
func _on_button_mouse_exited(button: TextureButton) -> void:
	start_tween(button, "scale", Vector2.ONE, tween_duration)
		
func getNextPower():
	if ItemManager.remainingPowersKeys.is_empty():
		ItemManager.resetPool()
	powerKey = ItemManager.remainingPowersKeys.pop_back()
	return powerKey
	
func buyItem(currentShopSlot: int):
	if GameManager.souls >= shopPowers[currentShopSlot]["Cost"]:
		GameManager.souls = GameManager.souls - shopPowers[currentShopSlot]["Cost"]
		if ItemManager.inventory[0].is_empty() and !shopPowers[currentShopSlot]["Type"]=="health":
			ItemManager.inventory[0] = shopPowers[currentShopSlot]
			return
		if shopPowers[currentShopSlot]["Type"] == "gun":
			for i in ItemManager.inventory:
				if ItemManager.inventory[i]["Type"] == "gun":
					ItemManager.inventory[i] = shopPowers[currentShopSlot]
					return
			ItemManager.inventory[ItemManager.inventory.size()]=shopPowers[currentShopSlot]
			return
		if shopPowers[currentShopSlot]["Type"] =="trajectory":
			for i in ItemManager.inventory:
				if ItemManager.inventory[i]["Type"] == "trajectory":
					ItemManager.inventory[i] = shopPowers[currentShopSlot]
					return
			ItemManager.inventory[ItemManager.inventory.size()]=shopPowers[currentShopSlot]
			return
		if shopPowers[currentShopSlot]["Type"] =="health":
			print("entrou no if do health")
			if GameManager.currentGunLife + 1 <= GameManager.gunStats["life"]:
				GameManager.currentGunLife += 1
				return
			else:
				return
		else:
			ItemManager.inventory[ItemManager.inventory.size()]=shopPowers[currentShopSlot]
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

func checkInventoryEmpty():
	if !ItemManager.inventory[0].is_empty():
		ItemManager.isInventoryUpdated()


func _on_button_pressed(button: TextureButton) -> void:
	var currentItemSlot =  int(button.name.trim_prefix("Power"))
	if !hasEnoughSouls(button):
		showInsufficientSouls()
		return
	buyItem(currentItemSlot)
	checkInventoryEmpty()
	showPowerPurchasedMessage(button)
	updateSouls()
	button.disabled = true

func _on_continue_next_wave_pressed() -> void:
	GameManager.changeSceneGame()
	checkInventoryEmpty()
	print(ItemManager.inventory)
	
