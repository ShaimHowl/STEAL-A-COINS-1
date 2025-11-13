extends CharacterBody2D


@export var speed= 200
@export var jump = -300
# Obtener la gravedad desde la configuración del proyecto para sincronizar con nodos RigidBody.
var gravity = 980
@onready var animated_sprite_2d = $AnimatedSprite2D
func _physics_process(delta):
	# Aplicar la gravedad.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Manejar el salto.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump
  
	# Obtener la dirección del input y manejar el movimiento/desaceleración.
	# Como buena práctica, deberías reemplazar las acciones UI por acciones personalizadas de juego.
	var direction = Input.get_axis("move_left", "move_right")
	if direction < 0:
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		animated_sprite_2d.flip_h = false
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
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
