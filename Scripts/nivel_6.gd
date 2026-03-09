extends Node2D

@export var escena_final: String = "res://Scenes/misionfallida.tscn"

func _ready():
	# Reiniciar monedas al entrar en la misión
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()

	# Contar cuántas monedas hay en la escena
	GameData.monedas_totales = get_tree().get_nodes_in_group("moneda").size()

func terminar_mision():
	# Pequeño retraso opcional
	await get_tree().create_timer(0.10).timeout
	get_tree().change_scene_to_file("res://Scenes/mision3.tscn")

func _cuando_termina_el_tiempo():
	# Ya no se usa, pero lo dejo por si lo llamas manualmente
	get_tree().change_scene_to_file(escena_final)
