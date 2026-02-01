extends Area2D

@export var cantidad_cura: int = 5
@onready var sonido = $AudioStreamPlayer2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.curar(cantidad_cura)
		sonido.play()
		hide() # desaparece visualmente
		set_deferred("monitoring", false) # evita volver a activarse
		await sonido.finished
		queue_free()
