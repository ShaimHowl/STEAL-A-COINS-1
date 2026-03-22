extends Control

@onready var reglas := $Label2
@onready var aviso := $Label3
@onready var boton := $Button
@onready var tecla_audio: AudioStreamPlayer = $Audio

func _ready() -> void:
	aviso.visible = false
	boton.visible = false

	await reglas.type_text()

	# ⏳ Esperar 2 segundos
	await get_tree().create_timer(1.0).timeout

	aviso.visible = true
	await aviso.type_text()

	# 🟢 Mostrar botón al final
	boton.visible = true


func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	tecla_audio.play()
	get_tree().change_scene_to_file("res://Scenes/Detalles.tscn")
