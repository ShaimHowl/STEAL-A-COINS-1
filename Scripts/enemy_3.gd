extends CharacterBody2D

const ENEMY_RUN = 160
const GRAVEDAD = 98
const JUMP_FORCE = -350

@export_enum("left", "right") var start_direction: String = "left"   # ← OPCIÓN EN INSPECTOR

var jugador_en_area: Node2D = null

@onready var area: Area2D = $Area2D
@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_hit: AudioStreamPlayer = $AudioStreamPlayer
@onready var jump_timer: Timer = $JumpTimer

func _ready():
	# Dirección inicial
	if start_direction == "left":
		velocity.x = -ENEMY_RUN
		sprite.flip_h = false
		area.scale.x = 1
	else:
		velocity.x = ENEMY_RUN
		sprite.flip_h = true
		area.scale.x = -1

	sprite.play("run")

	area.body_entered.connect(_on_area_enter)
	area.body_exited.connect(_on_area_exit)
	timer.timeout.connect(_daño_constante)

	jump_timer.timeout.connect(_hacer_salto)
	jump_timer.start()

func _physics_process(_delta):
	velocity.y += GRAVEDAD

	# Gira al tocar pared
	if is_on_wall():
		if !sprite.flip_h:
			velocity.x = ENEMY_RUN
		else:
			velocity.x = -ENEMY_RUN

	# Dirección visual
	if velocity.x < 0:
		sprite.flip_h = false
		area.scale.x = 1
	else:
		sprite.flip_h = true
		area.scale.x = -1

	move_and_slide()

	# Mantener animación de correr incluso en el aire
	if sprite.animation != "jump":
		sprite.play("run")

func _hacer_salto():
	if is_on_floor():
		velocity.y = JUMP_FORCE
		sprite.play("jump")

func _on_area_enter(body: Node2D) -> void:
	if body.is_in_group("enemy
	"):
		jugador_en_area = body
		jugador_en_area.recibir_daño(100)
		audio_hit.play()
		timer.start()

func _on_area_exit(body: Node2D) -> void:
	if body == jugador_en_area:
		jugador_en_area = null
		timer.stop()

func _daño_constante() -> void:
	if jugador_en_area and jugador_en_area.has_method("recibir_daño"):
		jugador_en_area.recibir_daño(100)
		audio_hit.play()
