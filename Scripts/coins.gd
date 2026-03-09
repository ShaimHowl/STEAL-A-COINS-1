extends Area2D

@export var id_moneda: String = ""  # ID única asignada desde el editor

func _ready() -> void:
	# Si ya fue recogida antes, no se muestra
	if id_moneda in GameData.monedas_recogidas:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	# ACEPTA jugador y jugador1
	if (body.name == "jugador" or body.name == "jugador1") \
	and not (id_moneda in GameData.monedas_recogidas):

		GameData.monedas += 1
		GameData.monedas_recogidas.append(id_moneda)

		$PickupSound.play()
		$AnimatedSprite2D.play("default")

		await get_tree().create_timer(0.1).timeout
		queue_free()

		# ¿Se recogieron todas?
		if GameData.monedas == GameData.monedas_totales:
			get_parent().terminar_mision()
