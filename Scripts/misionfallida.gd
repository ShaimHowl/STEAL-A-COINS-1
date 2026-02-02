extends CanvasLayer

@onready var titulo = $LabelTitulo
@onready var texto = $LabelTexto
@onready var sonidoF = $SonidoMisionF

func _ready():
	titulo.text = "MISIÓN FALLIDA"
	sonidoF.play()

	texto.text = "Has cogido %d de %d monedas" % [
		GameData.monedas,
		GameData.monedas_totales
	]

func _on_button_pressed() -> void:
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()
	get_tree().change_scene_to_file("res://Scenes/mundo.tscn")


func _on_button_2_pressed() -> void:
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
