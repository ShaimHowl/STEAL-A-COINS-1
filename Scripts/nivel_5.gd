extends Node2D



var tiempo_restante: float

func _ready():
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()
	GameData.monedas_totales = get_tree().get_nodes_in_group("moneda").size()



func terminar_mision():
	await get_tree().create_timer(0.10).timeout  # ⏳ medio segundo de retraso
	get_tree().change_scene_to_file("res://Scenes/mision5.tscn")
func _cuando_termina_el_tiempo():
	get_tree().change_scene_to_file("res://Scenes/misionfallida.tscn")
