extends Control

@export var iniciarButton: Button
@export var cenaPrincipal: PackedScene


func _on_iniciar_button_pressed() -> void:
	get_tree().change_scene_to_packed(cenaPrincipal)
