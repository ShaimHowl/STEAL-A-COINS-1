extends CharacterBody2D

@export var speed = 200
@export var jump = -350

var gravity = 980
var attacking = false

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta

	# ---- ATAQUE 1 ----
	if Input.is_action_just_pressed("Attack") and not attacking:
		attacking = true
		animated_sprite_2d.play("Attack")
		 
	# ---- ATAQUE 2 ----
	if Input.is_action_just_pressed("Attack2") and not attacking:
		attacking = true
		animated_sprite_2d.play("Attack2")

	# Si está atacando, esperar a que termine la animación
	if attacking:
		# Cuando termine la animación (asegúrate de que NO esté en loop)
		if not animated_sprite_2d.is_playing():
			attacking = false
		# PERO dejar que pueda seguir moviéndose
		# Así que NO bloqueamos movimiento, solo animación
		pass

	# ---- SALTO ----
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump
  
	var direction = Input.get_axis("move_left", "move_right")

	# Flip horizontal
	if direction < 0:
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		animated_sprite_2d.flip_h = false

	# Animaciones de movimiento (solo si NO está atacando)
	if not attacking:
		if is_on_floor():
			if direction == 0:
				animated_sprite_2d.play("Idle")
			else:
				animated_sprite_2d.play("run")
		else:
			if velocity.y < 0:
				animated_sprite_2d.play("jump")
			else:
				animated_sprite_2d.play("fall")

	# Movimiento horizontal (siempre permitido)
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
