extends Control

@export var iniciarButton: Button
@export var cenaPrincipal: PackedScene
@onready var credits = $Credits


func _on_iniciar_button_pressed() -> void:
	get_tree().change_scene_to_packed(cenaPrincipal)


func _on_back_button_pressed() -> void:
	credits.visible = false


func _on_credits_button_pressed() -> void:
	credits.visible = true
