class_name PowerManager
extends Node

var currentPowerScene : PackedScene
var powerNode : Node

func _ready() -> void:
	if GameManager.inventoryUpdatedFlag:
		_on_upgrade_buyed()
		GameManager.inventoryUpdatedFlag = false
	
func _on_upgrade_buyed():
	for i in GameManager.inventory:
		currentPowerScene = GameManager.inventory[i]["Scene"]
		powerNode = currentPowerScene.instantiate()
		if GameManager.inventory[i]["Type"]== "Bullet Modifier" or  GameManager.inventory[i]["Type"]== "Trajectory" or  GameManager.inventory[i]["Type"]== "Power":
			if has_node("BulletSpawner/"+powerNode.name):
				pass
			else:
				get_parent().get_child(0).add_child(powerNode)
		elif GameManager.inventory[i]["Type"]== "Gun Modifier" or GameManager.inventory[i]["Type"] == "Gun":
			if GameManager.inventory[i]["Type"]=="Gun":
				if get_parent().has_node("ArmaDeFogo"):
					get_parent().get_node("ArmaDeFogo").queue_free()
				if get_parent().has_node("IceGun"):
					get_parent().get_node("IceGun").queue_free()
				if get_parent().has_node("GoldGun"):
					get_parent().get_node("GoldGun").queue_free()
			if has_node("/"+powerNode.name):
				pass
				
			else:
				add_sibling.call_deferred(powerNode)
		else:
			push_error("vmtnc")
	
	
