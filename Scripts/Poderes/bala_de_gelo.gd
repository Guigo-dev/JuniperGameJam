extends Bala


@export var pocoGelo: PackedScene

func apply_effects():
	if maxpen == penetration:
		var poco = pocoGelo.instantiate()
		poco.global_position = global_position
		get_parent().get_parent().add_child.call_deferred(poco)

		
		
