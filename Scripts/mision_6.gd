extends CanvasLayer

@onready var titulo = $LabelTitulo
@onready var texto = $LabelTexto
@onready var sonido = $SonidoMision
@onready var tecla_audio: AudioStreamPlayer = $Audio

var titulo_completo := ""
var texto_completo := ""

var velocidad_titulo := 0.06
var velocidad_texto := 0.04

func _ready():
	if GameData.monedas == GameData.monedas_totales:
		titulo_completo = "MISIÓN COMPLETADA"
		sonido.play()
	else:
		titulo_completo = "MISIÓN FALLIDA"

	texto_completo = "Has cogido %d de %d monedas" % [
		GameData.monedas,
		GameData.monedas_totales
	]

	# Mostrar directamente sin animación
	titulo.text = titulo_completo
	texto.text = texto_completo






func _on_button_pressed() -> void:
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/mundo.tscn")
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()

func _on_button_3_pressed() -> void:
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()
