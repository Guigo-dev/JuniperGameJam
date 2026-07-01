class_name PowerManager
extends Node

var currentPowerScene : PackedScene
var powerNode : Node
var power_up_types_count = 2
#var bulletSpawnerChildNodes = {0:{}}
#var gunChildNodes = {0:{}}
var alreadyEquippedItems = {0:{}}

#verifica se o inventário atualizou
func _ready() -> void:
	if ItemManager.inventoryUpdatedFlag:
		#sortTypes()
		_on_upgrade_buyed()
		ItemManager.inventoryUpdatedFlag = false

#func updateInventory():
	#alreadyEquippedItems = ItemManager.inventory
	
#func sortTypes():
	#var index1 = 0
	#var index2 = 0
	#for i in ItemManager.powers:
		#if ItemManager.powers[i]["Type"]== ItemManager.BULLET_MODIFIER or  ItemManager.powers[i]["Type"]== ItemManager.TRAJECTORY or  ItemManager.powers[i]["Type"]== ItemManager.POWER:
			#bulletSpawnerChildNodes[index1] = ItemManager.powers[i]
			#index1+=1
		#if ItemManager.powers[i]["Type"]== ItemManager.GUN_MODIFIER or ItemManager.powers[i]["Type"] == ItemManager.GUN:
			#gunChildNodes[index2] = ItemManager.powers[i]
			#index2+=1

func isItemAlreadyEquipped(index : int):
	for currentItem in alreadyEquippedItems:
		if ItemManager.inventory[index]["Name"] == alreadyEquippedItems[currentItem]["Name"]:
			return true
	return false

func isExclusiveItem(index: int):
	if ItemManager.inventory[index]["Type"] in ItemManager.EXCLUSIVE_ITEMS:
		return true
	return false


func isEquippedItemsEmpty():
	if alreadyEquippedItems[0].is_empty():
		return true
	return false

func getEquippedExclusiveItemName(index : int):
	for currentItem in alreadyEquippedItems:
		if ItemManager.inventory[index]["Type"] == alreadyEquippedItems[currentItem]["Type"]:
			return alreadyEquippedItems[currentItem]["NodeName"]
	return false
	
func _on_upgrade_buyed():
	if ItemManager.inventory[0].is_empty():
		return
	for i in ItemManager.inventory:
		currentPowerScene = ItemManager.inventory[i]["Scene"]
		powerNode = currentPowerScene.instantiate()
		if isEquippedItemsEmpty():
			add_child(powerNode)
			alreadyEquippedItems[0] = ItemManager.inventory[i]
		elif !isItemAlreadyEquipped(i):
			if isExclusiveItem(i):
				get_node_or_null(getEquippedExclusiveItemName(i)).queue_free()
				add_child(powerNode)
			else:
				add_child(powerNode)
