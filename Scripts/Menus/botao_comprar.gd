extends TextureButton



#Transforma o png do botão em bitmap e aplica uma mask pra "hitbox" do botão ser igual ao tamanho da imagem
func _ready() -> void:
	if texture_normal:
		var image = texture_normal.get_image()
		var bitmap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap
		
func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			pass
			
