extends CharacterBody2D

const enemyrun = 100
const gravedad = 98

var jugador_en_area: Node2D = null

@onready var area: Area2D = $Area2D
@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_hit: AudioStreamPlayer = $AudioStreamPlayer   # ← AGREGADO

func _ready():
	velocity.x = -enemyrun
	sprite.play("run")

	area.body_entered.connect(_on_area_enter)
	area.body_exited.connect(_on_area_exit)
	timer.timeout.connect(_daño_constante)

func _physics_process(_delta):
	velocity.y += gravedad

	# Gira al tocar pared, incluso si está atacando
	if is_on_wall():
		if !sprite.flip_h:
			velocity.x = enemyrun
		else:
			velocity.x = -enemyrun

	# Actualiza dirección visual y el área de daño
	if velocity.x < 0:
		sprite.flip_h = false
		area.scale.x = 1
	elif velocity.x > 0:
		sprite.flip_h = true
		area.scale.x = -1

	move_and_slide()

func _on_area_enter(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		jugador_en_area = body
		jugador_en_area.recibir_daño(5) # 💥 DAÑO INMEDIATO
		audio_hit.play()
		timer.start()
		
func _on_area_exit(body: Node2D) -> void:
	if body == jugador_en_area:
		jugador_en_area = null
		timer.stop()

func _daño_constante() -> void:
	if jugador_en_area and jugador_en_area.has_method("recibir_daño"):
		jugador_en_area.recibir_daño(5)
		audio_hit.play()   # ← AGREGADO
