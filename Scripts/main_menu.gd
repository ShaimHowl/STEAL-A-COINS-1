extends Control

@onready var tecla_audio: AudioStreamPlayer = $Audio
@onready var label := $Titulo   # Asegúrate del nombre del nodo

func _ready():
	_animar_label()


func _animar_label():
	var tween = create_tween().set_loops()  # animación infinita

	# --- PARPADEO (fade in/out) ---
	tween.tween_property(label, "modulate:a", 0.3, 0.5) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(label, "modulate:a", 1.0, 0.5) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# --- MOVIMIENTO SUAVE (arriba/abajo) ---
	tween.tween_property(label, "position:y", label.position.y - 7, 0.25) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(label, "position:y", label.position.y + 7, 0.25) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_comenzar_pressed():
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/regla.tscn")
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()


func _on_opciones_pressed():
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/Detalles.tscn")
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()


func _on_salir_pressed():
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
