extends Area2D

@export var daño_por_tick := 1
@export var daño_total := 115
@export var tiempo_entre_ticks := 0.3

var daño_acumulado := 0
var objetivo: Node = null
var timer: Timer

func _ready():
	timer = Timer.new()
	timer.wait_time = tiempo_entre_ticks
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if objetivo != null:
		return

	if body.is_in_group("jugador"):
		objetivo = body
		daño_acumulado = 0

		hide()

		if has_node("CollisionShape2D"):
			$CollisionShape2D.disabled = true

		timer.start()

func _on_timer_timeout():
	if objetivo == null:
		timer.stop()
		queue_free()
		return

	if daño_acumulado < daño_total:
		if objetivo.has_method("recibir_daño"):
			objetivo.recibir_daño(daño_por_tick, true)
			daño_acumulado += daño_por_tick
	else:
		timer.stop()
		queue_free()
