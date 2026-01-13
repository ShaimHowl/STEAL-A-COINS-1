extends Node2D

func _input(_event: InputEvent) -> void:
	# ESC → abrir/cerrar pausa
	if Input.is_action_just_pressed("ui_accept"):
		
		# Si el menú NO está visible → abrir pausa
		if not $VBoxContainer.visible:
			get_tree().paused = true
			$VBoxContainer.visible = true
			$ColorRect.visible = true
		
		# Si el menú SÍ está visible → cerrar pausa
		else:
			get_tree().paused = false
			$VBoxContainer.visible = false
			$ColorRect.visible = false


func _on_button_2_pressed() -> void:
	_volver_al_menu()

func _on_button_pressed() -> void:
	_reiniciar_mundo()


func _reiniciar_mundo():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/mundo.tscn")
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()


func _volver_al_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()
