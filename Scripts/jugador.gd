extends CharacterBody2D

@export var speed = 150
@export var run_speed = 260
@export var jump = -360
@export var max_health = 100
@export var start_facing_left := false

@export var tiempo_invulnerable := 0.5
@export var tiempo_flash := 0.07

var health
var gravity = 940
var muerto = false
var mirando_izquierda = false
var invulnerable = false

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	health = GameData.health
	add_to_group("jugador")

	mirando_izquierda = start_facing_left
	animated_sprite_2d.flip_h = mirando_izquierda

func _physics_process(delta):
	if muerto:
		return

	# Flip manual
	if Input.is_action_just_pressed("flip"):
		mirando_izquierda = !mirando_izquierda
		animated_sprite_2d.flip_h = mirando_izquierda

	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Saltar
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump

	# Movimiento horizontal
	var direction = Input.get_axis("move_left", "move_right")

	var current_speed = speed
	if Input.is_action_pressed("run") and direction != 0:
		current_speed = run_speed

	# Mirar izquierda/derecha
	if direction < 0:
		mirando_izquierda = true
	elif direction > 0:
		mirando_izquierda = false

	animated_sprite_2d.flip_h = mirando_izquierda

	# Animaciones
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("Idle")
		else:
			if current_speed == run_speed:
				animated_sprite_2d.play("run")
			else:
				animated_sprite_2d.play("walk")
	else:
		if velocity.y < 0:
			animated_sprite_2d.play("jump")
		else:
			animated_sprite_2d.play("fall")

	# Aplicar movimiento
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = 0

	move_and_slide()

# ===============================
# DAÑO Y MUERTE
# ===============================

func recibir_daño(cantidad, ignorar_invulnerabilidad := false):
	if muerto:
		return

	if invulnerable and not ignorar_invulnerabilidad:
		return

	health -= cantidad
	GameData.health = health
	print("Vida:", health)

	activar_invulnerabilidad()

	if health <= 0:
		morir()

# ===============================
# PARPADEO CON AWAIT
# ===============================

func activar_invulnerabilidad():
	invulnerable = true
	var tiempo := 0.0

	while tiempo < tiempo_invulnerable:
		animated_sprite_2d.modulate = Color(1, 0, 0)
		await get_tree().create_timer(tiempo_flash).timeout

		animated_sprite_2d.modulate = Color(1, 1, 1)
		await get_tree().create_timer(tiempo_flash).timeout

		tiempo += tiempo_flash * 2

	invulnerable = false

# ===============================
# CURAR
# ===============================

func curar(cantidad):
	if muerto:
		return

	health += cantidad
	if health > max_health:
		health = max_health

	GameData.health = health
	print("Curado. Vida actual:", health)

# ===============================
# MUERTE
# ===============================

func morir():
	muerto = true
	velocity = Vector2.ZERO
	animated_sprite_2d.modulate = Color(1, 1, 1)
	animated_sprite_2d.play("")

	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/misionfallida.tscn")
