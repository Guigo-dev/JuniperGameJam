extends Line2D

var previous_position: Vector2
var bullet_end: float 

func _ready() -> void:
	var texture = get_parent().texture
	bullet_end = 3.4
	previous_position = get_parent().global_position
	
func _process(delta: float) -> void:
	var current_position = get_parent().global_position
	var direction = (current_position - previous_position).normalized()
	
	add_point(current_position - bullet_end * direction)
	if(points.size()>50):
		remove_point(0)
	
	previous_position = current_position
