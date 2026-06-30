class_name PowerManager
extends Node

var currentPowerScene : PackedScene
var powerNode : Node
var power_up_types_count = 2
var bulletSpawnerChildNodes = {0:{}}
var gunChildNodes = {0:{}}
var currentExistingItemNodes : Array

#verifica se o inventário atualizou
func _ready() -> void:
	if ItemManager.inventoryUpdatedFlag:
		currentExistingItemNodes = get_tree().get_nodes_in_group("item")
		sortTypes()
		_on_upgrade_buyed()
		ItemManager.inventoryUpdatedFlag = false

func sortTypes():
	var index1 = 0
	var index2 = 0
	for i in ItemManager.powers:
		if ItemManager.powers[i]["Type"]== ItemManager.BULLET_MODIFIER or  ItemManager.powers[i]["Type"]== ItemManager.TRAJECTORY or  ItemManager.powers[i]["Type"]== ItemManager.POWER:
			bulletSpawnerChildNodes[index1] = ItemManager.powers[i]
			index1+=1
		if ItemManager.powers[i]["Type"]== ItemManager.GUN_MODIFIER or ItemManager.powers[i]["Type"] == ItemManager.GUN:
			gunChildNodes[index2] = ItemManager.powers[i]
			index2+=1

func isItemAlreadyEquipped(index : int):
	for j in currentExistingItemNodes:
		if ItemManager.inventory[index]["Name"] == currentExistingItemNodes[j].name:
			return true
	return false

func isExclusiveItem(index: int):
	if ItemManager.inventory[index]["Type"] in ItemManager.EXCLUSIVE_ITEMS:
		return true
	return false

func replaceExclusiveItem(group : String, itemNode : Node):
	for i in currentExistingItemNodes:
		if currentExistingItemNodes[i].is_in_group(group):
			var parent = currentExistingItemNodes[i].get_parent()
			currentExistingItemNodes[i].queue_free()
			parent.add_child(itemNode)
			return
	add_sibling.call_deferred(itemNode)

func _on_upgrade_buyed():
	if ItemManager.inventory[0].is_empty():
			return
	for i in ItemManager.inventory:
		currentPowerScene = ItemManager.inventory[i]["Scene"]
		powerNode = currentPowerScene.instantiate()
		if !isItemAlreadyEquipped(i):
			if isExclusiveItem(i):
				replaceExclusiveItem(ItemManager.inventory[i]["Type"],powerNode)
			else:
				for j in bulletSpawnerChildNodes:
					if ItemManager.inventory[i] == bulletSpawnerChildNodes[j] and !has_node("BulletSpawner/"+powerNode.name):
						get_parent().get_child(0).add_child(powerNode)
				for j in gunChildNodes:
					if ItemManager.inventory[i] == gunChildNodes[j] and !get_parent().has_node(str(powerNode.name)):
						add_sibling.call_deferred(powerNode)
