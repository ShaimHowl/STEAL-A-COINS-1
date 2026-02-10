extends CanvasLayer

@onready var titulo = $LabelTitulo
@onready var texto = $LabelTexto
@onready var sonidoF = $SonidoMisionF

var texto_completo := ""
var velocidad := 0.05 # cuanto menor, más rápido

func _ready():
	titulo.text = "MISIÓN FALLIDA"
	sonidoF.play()

	texto_completo = "Has cogido %d de %d monedas" % [
		GameData.monedas,
		GameData.monedas_totales
	]

	texto.text = ""
	animar_texto()

func animar_texto():
	for i in texto_completo.length():
		texto.text += texto_completo[i]
		await get_tree().create_timer(velocidad).timeout



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mundo.tscn")




func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
