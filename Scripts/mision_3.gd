extends CanvasLayer

@onready var titulo = $LabelTitulo
@onready var texto = $LabelTexto
@onready var sonido = $SonidoMision
@onready var tecla_audio: AudioStreamPlayer = $Audio
func _ready():
	if GameData.monedas == GameData.monedas_totales:
		titulo.text = "MISIÓN COMPLETADA"
		sonido.play()  # ✅ solo si fue completada
	else:
		titulo.text = "MISIÓN FALLIDA"

	texto.text = "Has cogido %d de %d monedas" % [
		GameData.monedas,
		GameData.monedas_totales
	]


func _on_button_pressed() -> void:
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/detalles_4.tscn")



func _on_button_3_pressed() -> void:
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
