class_name PowerManager
extends Node

var currentItemScene : PackedScene
var itemNode : Node

#verifica se o inventário atualizou
func _ready() -> void:
	if ItemManager.inventoryUpdatedFlag:
		_on_upgrade_buyed()
		ItemManager.inventoryUpdatedFlag = false

func _on_upgrade_buyed():
	if ItemManager.inventory[0].is_empty():
		return
	for i in ItemManager.inventory:
		currentItemScene = ItemManager.inventory[i]["Scene"]
		itemNode = currentItemScene.instantiate()
		add_child(itemNode)
