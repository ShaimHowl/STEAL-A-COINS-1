extends CharacterBody2D

# ===============================
# EXPORTACIONES
# ===============================
@export var speed := 150
@export var run_speed := 260
@export var jump_force := -360
@export var max_health := 100
@export var start_facing_left := false
@export var tiempo_invulnerable := 0.5
@export var tiempo_flash := 0.07

# ===============================
# VARIABLES
# ===============================
var health: int
var gravity := 940
var muerto := false
var mirando_izquierda := false
var invulnerable := false

@onready var animated_sprite_2d = $AnimatedSprite2D

# ===============================
# INICIALIZACIÓN
# ===============================
func _ready():
	health = GameData.health
	add_to_group("jugador")
	mirando_izquierda = start_facing_left
	animated_sprite_2d.flip_h = mirando_izquierda

# ===============================
# PROCESO FÍSICO
# ===============================
func _physics_process(delta):
	if muerto:
		return

	_aplicar_gravedad(delta)
	_gestionar_salto()
	_gestionar_movimiento()
	_actualizar_animacion()
	move_and_slide()

# ===============================
# GRAVEDAD
# ===============================
func _aplicar_gravedad(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

# ===============================
# SALTO
# ===============================
func _gestionar_salto():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

# ===============================
# MOVIMIENTO HORIZONTAL
# ===============================
func _gestionar_movimiento():
	# Flip manual
	if Input.is_action_just_pressed("flip"):
		mirando_izquierda = !mirando_izquierda

	var direction = Input.get_axis("move_left", "move_right")
	var current_speed = run_speed if (Input.is_action_pressed("run") and direction != 0) else speed

	# Dirección del sprite
	if direction < 0:
		mirando_izquierda = true
	elif direction > 0:
		mirando_izquierda = false

	animated_sprite_2d.flip_h = mirando_izquierda

	velocity.x = direction * current_speed

# ===============================
# ANIMACIONES
# ===============================
func _actualizar_animacion():
	if is_on_floor():
		if velocity.x == 0:
			animated_sprite_2d.play("Idle")
		elif abs(velocity.x) == run_speed:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("walk")
	else:
		if velocity.y < 0:
			animated_sprite_2d.play("jump")
		else:
			animated_sprite_2d.play("fall")

# ===============================
# DAÑO Y MUERTE
# ===============================
func recibir_daño(cantidad, ignorar_invulnerabilidad := true):
	if muerto:
		return
	if invulnerable and not ignorar_invulnerabilidad:
		return

	health -= cantidad
	GameData.health = health
	print("Vida:", health)

	if not invulnerable:
		activar_invulnerabilidad()

	if health <= 0:
		morir()

# ===============================
# INVULNERABILIDAD
# ===============================
func activar_invulnerabilidad():
	invulnerable = true
	var tiempo := 0.0

	while tiempo < tiempo_invulnerable:
		if not is_inside_tree() or muerto:
			break
		animated_sprite_2d.modulate = Color(1, 0, 0)
		await get_tree().create_timer(tiempo_flash).timeout
		if not is_inside_tree() or muerto:
			break
		animated_sprite_2d.modulate = Color(1, 1, 1)
		await get_tree().create_timer(tiempo_flash).timeout
		tiempo += tiempo_flash * 2

	if is_inside_tree():
		animated_sprite_2d.modulate = Color(1, 1, 1)
	invulnerable = false

# ===============================
# CURAR
# ===============================
func curar(cantidad):
	if muerto:
		return
	health = min(health + cantidad, max_health)
	GameData.health = health
	print("Curado. Vida actual:", health)

# ===============================
# MUERTE
# ===============================
func morir():
	if muerto:
		return
	muerto = true
	velocity = Vector2.ZERO
	animated_sprite_2d.modulate = Color(1, 1, 1)
	animated_sprite_2d.play("")
	await get_tree().create_timer(1.0).timeout
	if is_inside_tree():
		get_tree().change_scene_to_file("res://Scenes/misionfallida.tscn")
