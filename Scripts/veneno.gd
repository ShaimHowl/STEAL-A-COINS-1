extends Area2D

@export var daño_por_tick: int = 2
@export var daño_total: int = 10
@onready var timer: Timer = Timer.new()

var daño_acumulado: int = 0
var objetivo: Node2D = null

func _ready():
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		objetivo = body
		daño_acumulado = 0
		timer.start()

func _on_body_exited(body: Node2D) -> void:
	if body == objetivo:
		timer.stop()
		objetivo = null

func _on_timer_timeout() -> void:
	if objetivo and daño_acumulado < daño_total:
		if objetivo.has_method("recibir_daño"):
			objetivo.recibir_daño(daño_por_tick)
			daño_acumulado += daño_por_tick
		else:
			print("El nodo jugador no tiene el método 'recibir_daño'")
	else:
		timer.stop()
		objetivo = null
