extends Node

var laser: Line2D

func _ready():
	laser = Line2D.new()
	laser.width = 2
	laser.default_color = Color.RED
	laser.antialiased = true

	get_parent().add_child(laser)

func _process(_delta):
	laser.position = Vector2.ZERO
	laser.rotation = 0

	laser.points = [
		Vector2.ZERO,
		Vector2.RIGHT * 5000
	]
