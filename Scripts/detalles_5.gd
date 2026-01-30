extends Node2D

@onready var tecla_audio: AudioStreamPlayer = $Audio

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	tecla_audio.play()
	get_tree().change_scene_to_file("res://Scenes/mundo.tscn")
