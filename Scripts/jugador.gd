extends CharacterBody2D

@export var speed = 150
@export var run_speed = 260
@export var jump = -360
@export var max_health = 100

@export var start_facing_left := false

var health
var gravity = 940
var muerto = false
var mirando_izquierda = false

var atacando = false  # Controla si está atacando

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	health = GameData.health
	add_to_group("jugador")

	mirando_izquierda = start_facing_left
	animated_sprite_2d.flip_h = mirando_izquierda

	animated_sprite_2d.connect("animation_finished", Callable(self, "_on_animation_finished"))


func _physics_process(delta):
	if muerto:
		return

	# ============================
	# ATAQUE (un solo clic, incluso en el aire)
	# ============================
	if Input.is_action_just_pressed("attack") and not atacando:
		_iniciar_ataque()

	# ============================
	# SI ESTÁ ATACANDO
	# ============================
	if atacando:
		# Mantener gravedad y movimiento aéreo
		if not is_on_floor():
			velocity.y += gravity * delta

		# Permitir movimiento horizontal en el aire
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x = direction * speed

		# Mantener orientación
		if direction < 0:
			mirando_izquierda = true
		elif direction > 0:
			mirando_izquierda = false

		animated_sprite_2d.flip_h = mirando_izquierda

		move_and_slide()
		return  # No reproducir otras animaciones


	# ============================
	# GIRO MANUAL
	# ============================
	if Input.is_action_just_pressed("flip"):
		mirando_izquierda = !mirando_izquierda
		animated_sprite_2d.flip_h = mirando_izquierda

	# ============================
	# MOVIMIENTO Y GRAVEDAD
	# ============================
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump

	var direction = Input.get_axis("move_left", "move_right")

	var current_speed = speed
	if Input.is_action_pressed("run") and direction != 0:
		current_speed = run_speed

	# Dirección automática
	if direction < 0:
		mirando_izquierda = true
	elif direction > 0:
		mirando_izquierda = false

	animated_sprite_2d.flip_h = mirando_izquierda

	# ============================
	# ANIMACIONES
	# ============================
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

	# Movimiento horizontal
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = 0

	move_and_slide()


# ===============================
# ATAQUE
# ===============================

func _iniciar_ataque():
	atacando = true
	animated_sprite_2d.play("attack")  # IMPORTANTE: sin loop


func _on_animation_finished():
	if animated_sprite_2d.animation == "attack":
		atacando = false


# ===============================
# DAÑO Y MUERTE
# ===============================

func recibir_daño(cantidad):
	if muerto:
		return

	health -= cantidad
	GameData.health = health
	print("Vida:", health)

	if health <= 0:
		morir()


func curar(cantidad):
	if muerto:
		return

	health += cantidad

	if health > max_health:
		health = max_health

	GameData.health = health
	print("Curado. Vida actual:", health)


func morir():
	muerto = true
	velocity = Vector2.ZERO

	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/misionfallida.tscn")
