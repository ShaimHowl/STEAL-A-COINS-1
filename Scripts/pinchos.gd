extends Node2D

var jugador_en_contacto: Node2D = null
var tiempo_entre_daño := 0.3  # segundos entre cada golpe
var temporizador_daño := 0.0

func _physics_process(delta):
	if jugador_en_contacto != null:
		temporizador_daño -= delta
		if temporizador_daño <= 0.0:
			if jugador_en_contacto.has_method("recibir_daño"):
				jugador_en_contacto.recibir_daño(15)
				$AudioStreamPlayer.play()
			temporizador_daño = tiempo_entre_daño

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "jugador":
		jugador_en_contacto = body
		temporizador_daño = 0.0  # daño inmediato al entrar

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == jugador_en_contacto:
		jugador_en_contacto = null
