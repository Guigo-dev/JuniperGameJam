extends Bala

@export var pocoFogo: PackedScene

func apply_effects():
	if maxpen == penetration:
		var poco = pocoFogo.instantiate()
		poco.global_position = global_position
		get_parent().get_parent().add_child.call_deferred(poco)
