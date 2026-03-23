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

	# Limpiar antes de animar
	titulo.text = ""
	texto.text = ""

	# Animar título y luego texto
	await animar_titulo()
	await animar_texto()


func animar_titulo():
	for i in titulo_completo.length():
		titulo.text += titulo_completo[i]
		await get_tree().create_timer(velocidad_titulo).timeout


func animar_texto():
	for i in texto_completo.length():
		texto.text += texto_completo[i]
		await get_tree().create_timer(velocidad_texto).timeout


func _on_button_pressed() -> void:
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/detalles_4.tscn")


func _on_button_3_pressed() -> void:
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
