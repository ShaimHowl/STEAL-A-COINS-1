extends Control

@onready var tecla_audio: AudioStreamPlayer = $Audio
@onready var label := $Titulo
@onready var label2 := $Titulo2


func _ready():
	pass  # sin animaciones


func _process(_delta):
	pass


func _on_comenzar_pressed():
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/regla.tscn")
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()


func _on_opciones_pressed():
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/Detalles.tscn")
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()


func _on_salir_pressed():
	tecla_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
	GameData.health = GameData.max_health
	GameData.monedas = 0
	GameData.monedas_recogidas.clear()
