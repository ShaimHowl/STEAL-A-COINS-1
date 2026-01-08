extends Area2D

@export var cantidad_cura: int = 5

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.curar(cantidad_cura)
		queue_free()  # ← La poción desaparece
