class_name HealthComponent extends Node

@export var MAX_LIFE: int 
@export var lifePoints: int
signal died


func updateLP(modifier: int) -> void:
	if(lifePoints + modifier > MAX_LIFE):
		lifePoints = MAX_LIFE
	else :
		lifePoints += modifier
		
	if(lifePoints == 0):
		died.emit()
	
	
