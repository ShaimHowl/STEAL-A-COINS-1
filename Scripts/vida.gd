extends Node2D

func _ready():
	$health_ProgressBar.value = GameData.health

func _process(_delta):
	$health_ProgressBar.value = GameData.health
